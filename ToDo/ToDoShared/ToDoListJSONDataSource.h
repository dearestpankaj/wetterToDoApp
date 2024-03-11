//
//  ToDoListJSONDataSource.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 09.03.24.
//
#import <ToDoShared/TreeNode.h>

@interface ToDoListJSONDataSource : NSObject
    
-(BOOL) saveToDoList:(NSMutableArray<TreeNode *> *)todoList;
-(NSMutableArray<TreeNode *> *)getToDoList;
@end

