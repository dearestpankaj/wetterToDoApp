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
        _title = title;
        _children = [NSMutableArray array];
    }
    return self;
}

- (void)addChild:(TreeNode *)child {
    [self.children addObject:child];
}

@end

