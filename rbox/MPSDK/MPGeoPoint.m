//
//  MPGeoPoint.m
//  MPSDK
//
//  Created by Wan Wei on 14-3-2.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MPGeoPoint.h"

@implementation MPGeoPoint

-(id) initWithLatitude:(double)latitude longitude:(double)longitude  {
    self = [super init];
    if (self) {
        self.latitude = latitude;
        self.longitude = longitude;
    }
    
    return self;
}

/** @name Creating a MPGeoPoint */
/*!
 Create a MPGeoPoint object.  Latitude and longitude are set to 0.0.
 @result Returns a new MPGeoPoint.
 */
+ (MPGeoPoint *)geoPoint {
    return [[MPGeoPoint alloc] initWithLatitude:0.0 longitude:0.0];
}

/*!
 Creates a new MPGeoPoint object for the given CLLocation, set to the location's
 coordinates.
 @param location CLLocation object, with set latitude and longitude.
 @result Returns a new MPGeoPoint at specified location.
 */
+ (MPGeoPoint *)geoPointWithLocation:(CLLocation *)location {
    return [MPGeoPoint geoPointWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
}

/*!
 Creates a new MPGeoPoint object with the specified latitude and longitude.
 @param latitude Latitude of point in degrees.
 @param longitude Longitude of point in degrees.
 @result New point object with specified latitude and longitude.
 */
+ (MPGeoPoint *)geoPointWithLatitude:(double)latitude longitude:(double)longitude {
    return [[MPGeoPoint alloc] initWithLatitude:latitude longitude:longitude];
}

/*!
 Fetches the user's current location and returns a new MPGeoPoint object via the
 provided block.
 @param geoPointHandler A block which takes the newly created MPGeoPoint as an
 argument.
 */
+ (void)geoPointForCurrentLocationInBackground:(void(^)(MPGeoPoint *geoPoint, NSError *error))geoPointHandler {
    
}

/** @name Calculating Distance */

/*!
 Get distance in radians from this point to specified point.
 @param point MPGeoPoint location of other point.
 @result distance in radians
 */
- (double)distanceInRadiansTo:(MPGeoPoint*)point {
    return 0.0;
}

/*!
 Get distance in miles from this point to specified point.
 @param point MPGeoPoint location of other point.
 @result distance in miles
 */
- (double)distanceInMilesTo:(MPGeoPoint*)point {
    return 0.0;
}

/*!
 Get distance in kilometers from this point to specified point.
 @param point MPGeoPoint location of other point.
 @result distance in kilometers
 */
- (double)distanceInKilometersTo:(MPGeoPoint*)point {
    return 0.0;    
}


@end
