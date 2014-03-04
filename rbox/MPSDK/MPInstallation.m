//
//  MPInstallation.m
//  PFSDK
//
//  Created by Wan Wei on 14-3-2.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MPInstallation.h"

@implementation MPInstallation

+ (NSString *)mpClassName {
    return @"installation";
}

/** @name Targeting Installations */

/*!
 Creates a query for MPInstallation objects. The resulting query can only
 be used for targeting a MPPush. Calling find methods on the resulting query
 will raise an exception.
 */
+ (MPQuery *)query {
    return nil;
}

/** @name Accessing the Current Installation */

/*!
 Gets the currently-running installation from disk and returns an instance of
 it. If this installation is not stored on disk, returns a MPInstallation
 with deviceType and installationId fields set to those of the
 current installation.
 @result Returns a MPInstallation that represents the currently-running
 installation.
 */
+ (instancetype)currentInstallation {
    return nil;
}

/*!
 Sets the device token string property from an NSData-encoded token.
 */
- (void)setDeviceTokenFromData:(NSData *)deviceTokenData {
}


@end
