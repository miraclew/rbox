//
//  MP.h
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPConstants.h"
#import "MPObject.h"
#import "MPUser.h"
#import "MPFile.h"
#import "MPQuery.h"

@interface MP : NSObject

/** @name Connecting to Parse */

/*!
 Sets the applicationId and clientKey of your application.
 @param applicationId The application id for your Parse application.
 @param clientKey The client key for your Parse application.
 */
+ (void)setApplicationId:(NSString *)applicationId clientKey:(NSString *)clientKey;
+ (NSString *)getApplicationId;
+ (NSString *)getClientKey;

@end
