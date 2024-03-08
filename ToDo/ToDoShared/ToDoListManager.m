//
//  ToDoManager.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <Foundation/Foundation.h>
#import "ToDoListManager.h"

@implementation ToDoListManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _todoList = [[NSMutableArray alloc] init];
        _flatTodoList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addChild:(TreeNode *)child {
    [_todoList addObject:child];
}

- (NSMutableArray *) getToDoList {
    return _todoList;
}

- (NSMutableArray *) getFlattenedNodes {
    return [self flattenedNodeArray:_todoList];
}

- (NSMutableArray *) getFlattenedChildren:(TreeNode *) node {
    return [self flattenedNodeArray: node.children];
}

- (NSMutableArray *) flattenedNodeArray:(NSMutableArray*) array {
    NSMutableArray *_flatTodoList = [[[NSMutableArray alloc] init] autorelease];
    for (TreeNode *element in array) {
        [_flatTodoList addObject:element];
        
        if ([element children] != nil) {
            NSMutableArray *array1 = [self flattenedNodeArray:[element children]];
            for (TreeNode *element in array1) {
                [_flatTodoList addObject:element];
            }
        }
    }
    return _flatTodoList;
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
    if (node.identifier.length < 2) {
        nodeIdentifier = node.identifier;
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

- (void) remove: (TreeNode *) treeNode {
    _todoList = [self deleteNode:_todoList :treeNode];
}

- (NSMutableArray *) deleteNode:(NSMutableArray *) nodeArray : (TreeNode *) treeNode {
    for (NSInteger index = 0; index < nodeArray.count; index++) {
        TreeNode *element = nodeArray[index];
        if(element == treeNode) {
            [nodeArray removeObjectAtIndex: index];
            break;
        } else if([element children] != nil && [[element children] count] > 0) {
            [self deleteNode:[element children] :treeNode];
        }
        [element release];
    }
    return  nodeArray;
}

- (void)dealloc {
    [_todoList release];
    [_flatTodoList release];
    [super dealloc];
}

@end
