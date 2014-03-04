//
//  MPUser.h
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPConstants.h"
#import "MPObject.h"

@interface MPUser : MPObject

/*!
 Gets the currently logged in user from disk and return an instance of it.
 @result Return a MPUser that is the currently logged in user. If there is none, returns nil.
 */
+(instancetype) currentUser;

/// The session token form the MPUser. This is set by the server upon successful authentication.
@property (nonatomic, retain) NSString *sessionToken;

/*!
 Whether the user is an authenticated object for the device. An authenticated MPUser is one that is obtained via
 a signUp or logIn method. An authenticated object is required in order to save (with altered values) or delete it.
 */
- (BOOL)isAuthenticated;

/*!
 Creates a new MPUser.
 @result Returns a new MPUser object.
 */
+ (MPUser *)user;

/// The username for MPUser
@property (nonatomic, retain) NSString *username;

/**
 The password for the MPUser. This will not be filled in from the server with 
 the password. It's only meant to be set.
 */
@property (nonatomic, retain) NSString *password;

/// The email for the MPUser
@property (nonatomic, retain) NSString *email;

/*!
 Signs up the user. Make sure the password and username are set. This will also enforce that the username isn't aleady taken.
 @result Returns true if the sign up was successful.
 */
- (BOOL)signUp;

/*!
 Signs up the user. Make sure the password and username are set. This will also enforce that the username isn't aleady taken.
 @param error Error object to set on error.
 @result Returns true if the sign up was successful.
 */
- (BOOL)signUp:(NSError *)error;

/*!
 Signs up the user. Make sure the password and username are set. This will also enforce that the username isn't aleady taken.
 */
- (BOOL)signUpInBackground;

/*!
 Signs up the user asynchronously. Make sure that password and username are set. This will also enforce that the username
 isn't already taken.
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)signUpInBackgroundWithBlock:(MPBooleanResultBlock)block;

/*!
 Signs up the user asynchronously. Make sure that password and username are set. This will also enforce that the username
 isn't already taken.
 @param target Target object for the selector.
 @param selector The selector that will be called when the asynchrounous request is complete. It should have the following signature: (void)callbackWithResult:(NSNumber *)result error:(NSError **)error. error will be nil on success and set if there was an error. [result boolValue] will tell you whether the call succeeded or not.
 */
- (void)signUpInBackgroundWithTarget:(id)target selector:(SEL)selector;

/** @name Logging in */
/*!
 Makes a request to login a user with specified credentials. Returns an instance
 of the successfully logged in MPUser. This will also cache the user locally so
 that calls to currentUser will use the latest logged in user.
 @param username The username of the user.
 @param password The password of the user.
 @result Returns an instance of the MPUser on success. If login failed for either wrong password or wrong username, returns nil.
 */
+ (instancetype)logInWithUsername:(NSString *)username
                         password:(NSString *)password;

/*!
 Makes a request to login a user with specified credentials. Returns an
 instance of the successfully logged in MPUser. This will also cache the user
 locally so that calls to currentUser will use the latest logged in user.
 @param username The username of the user.
 @param password The password of the user.
 @param error The error object to set on error.
 @result Returns an instance of the MPUser on success. If login failed for either wrong password or wrong username, returns nil.
 */
+ (instancetype)logInWithUsername:(NSString *)username
                         password:(NSString *)password
                            error:(NSError **)error;

/*!
 Makes an asynchronous request to login a user with specified credentials.
 Returns an instance of the successfully logged in MPUser. This will also cache
 the user locally so that calls to currentUser will use the latest logged in user.
 @param username The username of the user.
 @param password The password of the user.
 */
+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password;

/*!
 Makes an asynchronous request to login a user with specified credentials.
 Returns an instance of the successfully logged in MPUser. This will also cache
 the user locally so that calls to currentUser will use the latest logged in user.
 The selector for the callback should look like: myCallback:(MPUser *)user error:(NSError **)error
 @param username The username of the user.
 @param password The password of the user.
 @param target Target object for the selector.
 @param selector The selector that will be called when the asynchrounous request is complete.
 */
+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                               target:(id)target
                             selector:(SEL)selector;

/*!
 Makes an asynchronous request to log in a user with specified credentials.
 Returns an instance of the successfully logged in MPUser. This will also cache
 the user locally so that calls to currentUser will use the latest logged in user.
 @param username The username of the user.
 @param password The password of the user.
 @param block The block to execute. The block should have the following argument signature: (MPUser *user, NSError *error)
 */
+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                                block:(MPUserResultBlock)block;

/** @name Logging Out */

/*!
 Logs out the currently logged in user on disk.
 */
+ (void)logOut;


@end
