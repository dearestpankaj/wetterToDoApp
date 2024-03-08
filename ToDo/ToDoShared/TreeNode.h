//
//  TreeNode.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

@interface TreeNode : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSMutableArray<TreeNode *> *children;
@property(nonatomic, strong) NSString *number;
@property(nonatomic, assign) bool isCompleted;

- (instancetype)initWithValue:(NSString *)title :(NSString *)number;
- (void)addChild:(TreeNode *)child;

@end
