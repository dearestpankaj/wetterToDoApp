//
//  ToDoListManager.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <ToDoShared/TreeNode.h>
#import <ToDoShared/ToDoListRepository.h>

@interface ToDoListService : NSObject

@property(nonatomic, retain) NSMutableArray<TreeNode *> *todoList;
@property(nonatomic, retain) ToDoListRepository *repository;

-(NSMutableArray *)getFlattenedNodes;
-(TreeNode *)getParentTreeNode:(TreeNode *)node;

-(id) initWithRepository: (ToDoListRepository *) repository;
-(void)saveNodeWithParent:(TreeNode *)parent andChild:(TreeNode *)child;

-(void)updateTodoItem:(TreeNode *)node andText:(NSString *)text;
-(void)setNodeAndChildrenCompletion:(TreeNode *)node :(bool)isComplete;
-(void)moveNodePostion:(TreeNode *)sourceNode :(TreeNode *) destinationNode;

-(NSMutableArray *)remove:(TreeNode *)treeNode;

@end
