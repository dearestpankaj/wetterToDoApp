//
//  ToDoListManager.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <ToDoShared/TreeNode.h>

@interface ToDoListService : NSObject


@property(nonatomic, strong) NSMutableArray<TreeNode *> *todoList;

- (NSMutableArray *) getFlattenedNodes;

- (void)saveNodeWithParent:(TreeNode *)parent andChild:(TreeNode *)child;
- (void)updateTodoItem:(TreeNode *)node andText:(NSString *)text;
- (void)setNodeAndChildrenCompletion:(TreeNode *) node :(bool) isComplete;
- (NSMutableArray *)remove:(TreeNode *) treeNode;
@end
