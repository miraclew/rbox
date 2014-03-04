//
//  MMPile.m
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MPFile.h"
#import "AFNetworking.h"

@implementation MPFile {
    NSString *_path;
}

-(id) initWithName:(NSString *)name
    contentsAtPath:(NSString *)path{
    self = [super init];
    if (self) {
        _name = name;
        _path = path;
    }
    
    return self;
}

+ (id)fileWithData:(NSData *)data {
    return nil;
}

+ (id)fileWithName:(NSString *)name data:(NSData *)data {
    return nil;
}

+ (id)fileWithName:(NSString *)name
    contentsAtPath:(NSString *)path {
    return [[MPFile alloc] initWithName:name contentsAtPath:path];
}

- (BOOL)save {
     return YES;
}

- (BOOL)save:(NSError **)error {
    return YES;
}

- (void)saveInBackground {
}

- (void)saveInBackgroundWithBlock:(MPBooleanResultBlock)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo": @"bar"};
    NSURL *filePath = [NSURL fileURLWithPath: _path];
    [manager POST:[NSString stringWithFormat:@"%@/files/upload", kMPServer] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"file" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)saveInBackgroundWithBlock:(MPBooleanResultBlock)block
                    progressBlock:(MPProgressBlock)progressBlock{
}

- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

- (NSData *)getData {
    return nil;
}

- (NSInputStream *)getDataStream {
    return nil;
}

- (NSData *)getData:(NSError **)error {
    return nil;
}

- (NSInputStream *)getDataStream:(NSError **)error {
     return nil;
}

- (void)getDataInBackgroundWithBlock:(MPDataResultBlock)block {
    
}

- (void)getDataStreamInBackgroundWithBlock:(MPDataStreamResultBlock)block {
    
}

- (void)getDataInBackgroundWithBlock:(MPDataResultBlock)resultBlock
                       progressBlock:(MPProgressBlock)progressBlock {
    
}

- (void)getDataStreamInBackgroundWithBlock:(MPDataStreamResultBlock)resultBlock
                             progressBlock:(MPProgressBlock)progressBlock {
    
}

- (void)getDataInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

- (void)cancel {
    
}


@end
