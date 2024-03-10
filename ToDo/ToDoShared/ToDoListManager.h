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
@property(nonatomic, strong) NSMutableArray<TreeNode *> *flatTodoList;


- (NSMutableArray *) getToDoList;
- (NSMutableArray *) getFlattenedNodes;
- (NSMutableArray *) getFlattenedChildren: (TreeNode *) node;

- (void)saveNodeWithParent:(TreeNode *)parent andChild:(TreeNode *)child;
- (void)updateTodoItemWithNode:(TreeNode *)node andText:(NSString *)text;
- (void) setNodeAndChildrenCompletion :(TreeNode *) node :(bool) isComplete;
- (NSMutableArray *) remove: (TreeNode *) treeNode;
@end
