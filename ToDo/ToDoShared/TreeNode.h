//
//  TreeNode.h
//  ToDo
//
//  Created by Pankaj Sachdeva on 05.03.24.
//

@interface TreeNode : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSMutableArray<TreeNode *> *children;

- (instancetype)initWithValue:(NSString *)value;
- (void)addChild:(TreeNode *)child;

@end
