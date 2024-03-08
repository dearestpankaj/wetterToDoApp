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
}

- (void)dealloc {
    [_todoList release];
    [_flatTodoList release];
    [super dealloc];
}

@end
