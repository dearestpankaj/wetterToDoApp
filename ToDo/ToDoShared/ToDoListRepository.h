//
//  ToDoListDataSource.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 09.03.24.
//

#import <ToDoShared/TreeNode.h>
#import <ToDoShared/ToDoListJSONDataSource.h>

@interface ToDoListRepository : NSObject

@property(nonatomic, retain) ToDoListJSONDataSource *dataSource;

-(instancetype)initWithDatasource: (ToDoListJSONDataSource *) dataSource;
-(BOOL)saveNodeList: (NSMutableArray<TreeNode *> *) todoList;
-(NSMutableArray<TreeNode *> *) getNodeList;

@end

