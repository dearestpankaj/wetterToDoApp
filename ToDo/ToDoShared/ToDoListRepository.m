//
//  ToDoListDataSource.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 09.03.24.
//

#import <Foundation/Foundation.h>
#import "ToDoListRepository.h"
#import "ToDoListJSONDataSource.h"

@implementation ToDoListRepository

-(void) saveNodeList: (NSMutableArray<TreeNode *> *) todoList {
    ToDoListJSONDataSource *datasource = [[ToDoListJSONDataSource alloc] init];
    [datasource saveToDoList:todoList];
    [datasource release];
}

-(NSMutableArray<TreeNode *> *) getNodeList {
    ToDoListJSONDataSource *datasource = [[ToDoListJSONDataSource alloc] init];
    return [datasource getToDoList];
}

- (void)dealloc {
    [super dealloc];
}

@end

