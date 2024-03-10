//
//  ToDoListDataSource.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 09.03.24.
//

#import <ToDoShared/TreeNode.h>

@interface ToDoListRepository : NSObject
    
-(void) saveNodeList: (NSMutableArray<TreeNode *> *) todoList;
-(NSMutableArray<TreeNode *> *) getNodeList;
@end

