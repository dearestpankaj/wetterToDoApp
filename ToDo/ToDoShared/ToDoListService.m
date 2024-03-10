//
//  ToDoManager.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <Foundation/Foundation.h>
#import "ToDoListService.h"
#import "ToDoListRepository.h"

@implementation ToDoListService

- (instancetype) init {
    self = [super init];
    if (self) {
        _todoList = [[NSMutableArray alloc] init];
        [self getToDoListFromDataSource];
    }
    return self;
}

- (void) getToDoListFromDataSource {
    ToDoListRepository *repository = [[ToDoListRepository alloc] init];
    _todoList = [repository getNodeList];
    [repository release];
}

/// Get list of TreeNode flattened to an array so that it can be easily displayed in UITableView
- (NSMutableArray *) getFlattenedNodes {
    return [self flattenedNodeArray:_todoList];
}

- (NSMutableArray *) flattenedNodeArray: (NSMutableArray*) nodeArray {
    NSMutableArray *flatTodoList = [[[NSMutableArray alloc] init] autorelease];
    for (TreeNode *element in nodeArray) {
        [flatTodoList addObject:element];
        
        if ([element children] != nil) {
            NSMutableArray *nodeChildrenArray = [self flattenedNodeArray:[element children]];
            for (TreeNode *element in nodeChildrenArray) {
                [flatTodoList addObject:element];
            }
        }
    }
    return flatTodoList;
}

///Save Node, if there is no parent it means the child should be added as root to root array
- (void)saveNodeWithParent:(TreeNode *)parent andChild:(TreeNode *)child {
    if (parent == nil) {
        [_todoList addObject:child];
    } else {
        [parent.children addObject:child];
    }
    [self saveToDoListToLocalDataStore];
}

- (void)updateTodoItem:(TreeNode *)node andText:(NSString *)text {
    node.title = text;
    [self saveToDoListToLocalDataStore];
}

-(void)saveToDoListToLocalDataStore {
    ToDoListRepository *repository = [[ToDoListRepository alloc] init];
    [self addIdentifierForNodes:_todoList :nil];
    [repository saveNodeList:_todoList];
    [repository release];
}

- (NSMutableArray *)addIdentifierForNodes:(NSMutableArray *) array :(NSString *)parentIdentifier {
    [array enumerateObjectsUsingBlock:^(TreeNode *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *identifier;
        if ([parentIdentifier length] > 0) {
            identifier = [NSString stringWithFormat:@"%@.%lu",parentIdentifier, (unsigned long)idx+1];
        } else {
            identifier = [NSString stringWithFormat:@"%lu",(unsigned long)idx+1];
        }
        obj.identifier = identifier;
        if ([obj children] != nil && [[obj children] count] > 0) {
            NSMutableArray *array1 = [self addIdentifierForNodes:obj.children :identifier];
            [array1 enumerateObjectsUsingBlock:^(TreeNode *obj1, NSUInteger idx1, BOOL * _Nonnull stop) {
                obj1.identifier = [NSString stringWithFormat:@"%@.%lu",obj1.identifier, (unsigned long)idx1+1];
            }];
        }
    }];
    return nil;
}

- (NSMutableArray *) getFlattenedChildren:(TreeNode *) node {
    return [self flattenedNodeArray: node.children];
}

- (void) setNodeAndChildrenCompletion: (TreeNode *) node :(bool) isComplete {
    node.isCompleted = isComplete;
    NSMutableArray *childNodes = [self getFlattenedChildren:node];
    for (TreeNode *node in childNodes) {
        node.isCompleted = isComplete;
    }
    TreeNode *parentNode = [self getParentTreeNode:node];
    if ([self checkIfAllSubTasksCompleted: parentNode]) {
        [parentNode setIsCompleted:true];
    }
    if (!node.isCompleted) {
        [self markParentNodeIncompleteForFirstIncompleteChildren:node];
    }
}

- (void) markParentNodeIncompleteForFirstIncompleteChildren: (TreeNode *) node {
    TreeNode *parentNode = [self getParentTreeNode:node];
    
    if (parentNode.children.firstObject.identifier == node.identifier) {
        [[self getParentTreeNode:node] setIsCompleted:false];
    }
}

- (BOOL) checkIfAllSubTasksCompleted: (TreeNode *) node {
    BOOL isTaskComplete = true;
    NSMutableArray *childNodes = [self getFlattenedChildren:node];
    for (TreeNode *node in childNodes) {
        if (!node.isCompleted) {
            isTaskComplete = false;
            break;
        }
    }
    return isTaskComplete;
}

- (TreeNode *) getParentTreeNode:(TreeNode *) node {
    NSString *nodeIdentifier = nil;
    if (![node.identifier containsString:@"."]) {
        return  nil;
    } else {
        nodeIdentifier = [node.identifier substringToIndex: node.identifier.length-2];
    }
    TreeNode *parentNode = [self searchNodeWith: nodeIdentifier];
    [nodeIdentifier release];
    return parentNode;
}

- (TreeNode *) searchNodeWith: (NSString *) nodeIdentifier {
    TreeNode *node = nil;
    NSMutableArray *childNodes = [self getFlattenedNodes];
    for (TreeNode *node in childNodes) {
        if (node.identifier == nodeIdentifier) {
            return node;
        }
    }
    return node;
}

- (NSMutableArray *) remove: (TreeNode *) treeNode {
    NSMutableArray<TreeNode *> *todoItemsBeforeDeletion = [self getFlattenedNodes];
    _todoList = [self deleteNode:_todoList :treeNode];
    NSMutableArray<TreeNode *> *todoItemsAfterDeletion = [self getFlattenedNodes];
    
    NSMutableArray *indexTobDeleted = [[[NSMutableArray alloc] init] autorelease];
    [todoItemsBeforeDeletion enumerateObjectsUsingBlock:^(TreeNode * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![todoItemsAfterDeletion containsObject:obj]) {
            [indexTobDeleted addObject:[NSNumber numberWithInt:idx]];
        }
    }];
    [self saveToDoListToLocalDataStore];
    [self getToDoListFromDataSource];
    return indexTobDeleted;
}

- (NSMutableArray *) deleteNode:(NSMutableArray *) nodeArray : (TreeNode *) treeNode {
    for (NSInteger index = 0; index < nodeArray.count; index++) {
        TreeNode *element = nodeArray[index];
        if(element.identifier == treeNode.identifier) {
            [nodeArray removeObjectAtIndex: index];
            break;
        } else if([element children] != nil && [[element children] count] > 0) {
            [self deleteNode:[element children] :treeNode];
        }
    }
    return  nodeArray;
}

-(void)moveNodePostion:(TreeNode *) sourceNode :(TreeNode *) destinationNode {
    TreeNode *sourceParent = [self getParentTreeNode:sourceNode];
    TreeNode *destinationParent = [self getParentTreeNode:destinationNode];
    
    if (sourceParent == nil && destinationParent == nil) {
        NSInteger destinationIndex = [_todoList indexOfObject:destinationNode];
        NSInteger sourceIndex = [_todoList indexOfObject:sourceNode];
        
        [_todoList exchangeObjectAtIndex:destinationIndex withObjectAtIndex:sourceIndex];
    } else {
        NSInteger destinationIndex = [destinationParent.children indexOfObject:destinationNode];
        NSInteger sourceIndex = [sourceParent.children indexOfObject:sourceNode];
        
        [sourceParent.children exchangeObjectAtIndex:destinationIndex withObjectAtIndex:sourceIndex];
    }
    [self saveToDoListToLocalDataStore];
}

- (void)dealloc {
    [_todoList release];
    [super dealloc];
}

@end