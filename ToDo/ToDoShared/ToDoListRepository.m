//
//  ToDoListDataSource.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 09.03.24.
//

#import <Foundation/Foundation.h>
#import "ToDoListRepository.h"

@implementation ToDoListRepository

-(instancetype)initWithDatasource: (ToDoListJSONDataSource *) dataSource {
    self = [super init];
    if (self) {
        _dataSource = [dataSource retain];
    }
    return self;
}

-(BOOL) saveNodeList: (NSMutableArray<TreeNode *> *) todoList {
    return [_dataSource saveToDoList:todoList];
}

-(NSMutableArray<TreeNode *> *) getNodeList {
    return [_dataSource getToDoList];
}

- (void)dealloc {
    [_dataSource release];
    [super dealloc];
}

@end

