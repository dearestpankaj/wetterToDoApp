//
//  ToDoListJSONDataSource.m
//  ToDoShared
//
//  Created by Pankaj Sachdeva on 09.03.24.
//

#import <Foundation/Foundation.h>
#import "ToDoListJSONDataSource.h"

@implementation ToDoListJSONDataSource

NSString *jsonFileName = @"todolist.json";
NSString const *keyTitle = @"title";
NSString const *keyIdentifier = @"identifier";
NSString const *keyChildren = @"children";

-(void) saveToDoList:(NSMutableArray<TreeNode *> *)todoList {
    NSMutableArray *array = [self convertArrayToJson:todoList];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] autorelease];
    [self writeStringToFile:jsonString];
}

-(NSMutableArray *) convertArrayToJson: (NSMutableArray *) array {
    NSMutableArray *mainArray = [NSMutableArray new];
    
    for (TreeNode *element in array) {
        NSMutableDictionary *node = [NSMutableDictionary new];
        [node setValue:element.title forKey:keyTitle];
        [node setValue:element.identifier forKey:keyIdentifier];
        
        if (element.children != nil && [[element children] count] > 0) {
            NSMutableArray *array1 = [self convertArrayToJson:element.children];
            [node setValue:array1 forKey:keyChildren];
        } else {
            [node setValue:nil forKey:keyChildren];
        }
        [mainArray addObject:node];
    }
    return mainArray;
}

- (void)writeStringToFile:(NSString*)aString {
    NSString *fileAtPath = [self jsonFilePath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}

-(NSMutableArray<TreeNode *> *)getToDoList {
    NSString *strJson = [self readStringFromFile];
    NSData *data = [strJson dataUsingEncoding:NSUTF8StringEncoding];
    id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *todoList = [self convertJSONObjectsToNodes:jsonOutput];
    
    return todoList;
}

- (NSString*) readStringFromFile {
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:[self jsonFilePath]] encoding:NSUTF8StringEncoding];
}

-(NSString *) jsonFilePath {
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:jsonFileName];
    return fileAtPath;
}

-(NSMutableArray *) convertJSONObjectsToNodes: (NSMutableArray *) jsonObjectArray {
    NSMutableArray *mainArray = [NSMutableArray new];
    
    for(id jsonObject in jsonObjectArray) {
        TreeNode *node = [[TreeNode alloc] initWithValue:[jsonObject objectForKey:keyTitle]];
        node.identifier = [jsonObject objectForKey:keyIdentifier];
        
        if ([jsonObject objectForKey:keyChildren] != nil) {
            NSMutableArray* childrenArray = [jsonObject valueForKey:keyChildren];
            if ([childrenArray count] > 0) {
                NSMutableArray *array1 = [self convertJSONObjectsToNodes: childrenArray];
                node.children = array1;
            } else {
                node.children = nil;
            }
        }
        [mainArray addObject:node];
    }
    
    return mainArray;
}

- (void)dealloc {
    [super dealloc];
}

@end
