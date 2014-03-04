//
//  MP.m
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MP.h"

NSString *const kMPServer = @"http://localhost:3000";
//NSString *const kMPServer = @"http://t1.ziyue.tv:3000";

static NSString *_applicationId;
static NSString *_clientKey;

@implementation MP {
}

/*!
 Sets the applicationId and clientKey of your application.
 @param applicationId The application id for your Parse application.
 @param clientKey The client key for your Parse application.
 */
+ (void)setApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey {
    _applicationId = applicationId;
    _clientKey = clientKey;
}

+ (NSString *)getApplicationId {
    return _applicationId;
}

+ (NSString *)getClientKey {
    return _clientKey;
}


@end
