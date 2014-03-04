//
//  MPConstants.h
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MPObject;
@class MPUser;

// Server
extern NSString *const kMPServer;

typedef void (^MPBooleanResultBlock)(BOOL succeeded, NSError *error);
typedef void (^MPIntegerResultBlock)(int number, NSError *error);
typedef void (^MPArrayResultBlock)(NSArray *objects, NSError *error);
typedef void (^MPObjectResultBlock)(MPObject *object, NSError *error);
typedef void (^MPSetResultBlock)(NSSet *channels, NSError *error);
typedef void (^MPUserResultBlock)(MPUser *user, NSError *error);
typedef void (^MPDataResultBlock)(NSData *data, NSError *error);
typedef void (^MPDataStreamResultBlock)(NSInputStream *stream, NSError *error);
typedef void (^MPStringResultBlock)(NSString *string, NSError *error);
typedef void (^MPIdResultBlock)(id object, NSError *error);
typedef void (^MPProgressBlock)(int percentDone);
