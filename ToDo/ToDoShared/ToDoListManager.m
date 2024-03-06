//
//  ToDoManager.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <Foundation/Foundation.h>
#import "ToDoListManager.h"

@implementation ToDoListManager


- (void)addChild:(TreeNode *)child {
    [_todoList addObject:child];
}

- (NSMutableArray *) getToDoList {
    return _todoList;
}

@end
