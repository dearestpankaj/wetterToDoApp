//
//  ToDoListManager.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <ToDoShared/TreeNode.h>

@interface ToDoListManager : NSObject

@property(nonatomic, assign) NSInteger value;
@property(nonatomic, strong) NSMutableArray<TreeNode *> *todoList;

- (void)addChild:(TreeNode *)child;

- (NSMutableArray *) getToDoList;

@end
