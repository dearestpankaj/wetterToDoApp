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
    }
    return self;
}

- (void)addChild:(TreeNode *)child {
    [_todoList addObject:child];
}

- (void)addNodeItem: (NSString *)title {
    TreeNode *node = [[[TreeNode alloc] initWithValue:title] autorelease];
    [_todoList addObject:node];
}

- (NSMutableArray *) getToDoList {
    return _todoList;
}

- (void)dealloc {
    [_todoList release];
    [super dealloc];
}

@end
