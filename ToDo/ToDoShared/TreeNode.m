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
        _children = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addChild:(TreeNode *)child {
    [_children addObject:child];
}

- (void)dealloc
{
    [_title release];
    [_children release];
    
    [super dealloc];
}

@end

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        // Create tree nodes
//        TreeNode *root = [[TreeNode alloc] initWithValue:1];
//        TreeNode *child1 = [[TreeNode alloc] initWithValue:2];
//        TreeNode *child2 = [[TreeNode alloc] initWithValue:3];
//        TreeNode *grandChild1 = [[TreeNode alloc] initWithValue:4];
//        TreeNode *grandChild2 = [[TreeNode alloc] initWithValue:5];
//
//        // Build the tree structure
//        [root addChild:child1];
//        [root addChild:child2];
//        [child1 addChild:grandChild1];
//        [child2 addChild:grandChild2];
//
//        // Access values
//        NSLog(@"Root Value: %ld", root.value); // 1
//        NSLog(@"Child 1 Value: %ld", root.children[0].value); // 2
//        NSLog(@"Child 2 Value: %ld", root.children[1].value); // 3
//        NSLog(@"Grandchild 1 Value: %ld", root.children[0].children[0].value); // 4
//        NSLog(@"Grandchild 2 Value: %ld", root.children[1].children[0].value); // 5
//    }
//    return 0;
//}
