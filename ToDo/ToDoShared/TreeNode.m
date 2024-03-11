//
//  TreeNode.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@implementation TreeNode

- (instancetype)initWithValue:(NSString *)title {
    self = [super init];
    if (self) {
        _isCompleted = false;
        _title = [title copy];
        _children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_identifier release];
    [_children release];
    
    [super dealloc];
}

@end

