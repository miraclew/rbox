//
//  MPInstallation.h
//  MPSDK
//
//  Created by Wan Wei on 14-3-2.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MPObject.h"
#import "MPQuery.h"

/*!
 A MP Framework Installation Object that is a local representation of an
 installation persisted to the MP cloud. This class is a subclass of a
 MPObject, and retains the same functionality of a MPObject, but also extends
 it with installation-specific fields and related immutability and validity
 checks.
 
 A valid MPInstallation can only be instantiated via
 [MPInstallation currentInstallation] because the required identifier fields
 are readonly. The timeZone and badge fields are also readonly properties which
 are automatically updated to match the device's time zone and application badge
 when the MPInstallation is saved, thus these fields might not reflect the
 latest device state if the installation has not recently been saved.
 
 MPInstallation objects which have a valid deviceToken and are saved to
 the MP cloud can be used to target push notifications.
 
 This class is currently for iOS only. There is no MPInstallation for MP
 applications running on OS X, because they cannot receive push notifications.
 */
@interface MPInstallation : MPObject

/*! The name of the Installation class in the REST API. This is a required
 *  MPSubclassing method */
+ (NSString *)mpClassName;

/** @name Targeting Installations */

/*!
 Creates a query for MPInstallation objects. The resulting query can only
 be used for targeting a MPPush. Calling find methods on the resulting query
 will raise an exception.
 */
+ (MPQuery *)query;

/** @name Accessing the Current Installation */

/*!
 Gets the currently-running installation from disk and returns an instance of
 it. If this installation is not stored on disk, returns a MPInstallation
 with deviceType and installationId fields set to those of the
 current installation.
 @result Returns a MPInstallation that represents the currently-running
 installation.
 */
+ (instancetype)currentInstallation;

/*!
 Sets the device token string property from an NSData-encoded token.
 */
- (void)setDeviceTokenFromData:(NSData *)deviceTokenData;

/** @name Properties */

/// The device type for the MPInstallation.
@property (nonatomic, readonly, retain) NSString *deviceType;

/// The installationId for the MPInstallation.
@property (nonatomic, readonly, retain) NSString *installationId;

/// The device token for the MPInstallation.
@property (nonatomic, retain) NSString *deviceToken;

/// The badge for the MPInstallation.
@property (nonatomic, assign) NSInteger badge;

/// The timeZone for the MPInstallation.
@property (nonatomic, readonly, retain) NSString *timeZone;

/// The channels for the MPInstallation.
@property (nonatomic, retain) NSArray *channels;


@end
