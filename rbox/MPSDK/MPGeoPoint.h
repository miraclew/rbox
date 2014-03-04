//
//  MPGeoPoint.h
//  PFSDK
//
//  Created by Wan Wei on 14-3-2.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/*!
 Object which may be used to embed a latitude / longitude point as the value for a key in a MPObject.
 MPObjects with a MPGeoPoint field may be queried in a geospatial manner using MPQuery's whereKey:nearGeoPoint:.
 
 This is also used as a point specifier for whereKey:nearGeoPoint: queries.
 
 Currently, object classes may only have one key associated with a GeoPoint type.
 */
@interface MPGeoPoint : NSObject

/** @name Creating a MPGeoPoint */
/*!
 Create a MPGeoPoint object.  Latitude and longitude are set to 0.0.
 @result Returns a new MPGeoPoint.
 */
+ (MPGeoPoint *)geoPoint;

/*!
 Creates a new MPGeoPoint object for the given CLLocation, set to the location's
 coordinates.
 @param location CLLocation object, with set latitude and longitude.
 @result Returns a new MPGeoPoint at specified location.
 */
+ (MPGeoPoint *)geoPointWithLocation:(CLLocation *)location;

/*!
 Creates a new MPGeoPoint object with the specified latitude and longitude.
 @param latitude Latitude of point in degrees.
 @param longitude Longitude of point in degrees.
 @result New point object with specified latitude and longitude.
 */
+ (MPGeoPoint *)geoPointWithLatitude:(double)latitude longitude:(double)longitude;

/*!
 Fetches the user's current location and returns a new MPGeoPoint object via the
 provided block.
 @param geoPointHandler A block which takes the newly created MPGeoPoint as an
 argument.
 */
+ (void)geoPointForCurrentLocationInBackground:(void(^)(MPGeoPoint *geoPoint, NSError *error))geoPointHandler;

/** @name Controlling Position */

/// Latitude of point in degrees.  Valid range (-90.0, 90.0).
@property (nonatomic) double latitude;
/// Longitude of point in degrees.  Valid range (-180.0, 180.0).
@property (nonatomic) double longitude;

/** @name Calculating Distance */

/*!
 Get distance in radians from this point to specified point.
 @param point MPGeoPoint location of other point.
 @result distance in radians
 */
- (double)distanceInRadiansTo:(MPGeoPoint*)point;

/*!
 Get distance in miles from this point to specified point.
 @param point MPGeoPoint location of other point.
 @result distance in miles
 */
- (double)distanceInMilesTo:(MPGeoPoint*)point;

/*!
 Get distance in kilometers from this point to specified point.
 @param point MPGeoPoint location of other point.
 @result distance in kilometers
 */
- (double)distanceInKilometersTo:(MPGeoPoint*)point;


@end
