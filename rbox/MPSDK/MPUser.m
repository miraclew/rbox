//
//  MPUser.m
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MPUser.h"
#import "AFNetworking.h"

@implementation MPUser {
    AFHTTPRequestOperationManager *manager;
}

-(id) init {
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

+(instancetype) currentUser {
    return nil;
}

- (BOOL)isAuthenticated {
    return false;
}

+ (MPUser *)user {
    MPUser *newUser = [[MPUser alloc] init];
    return newUser;
}

- (BOOL)signUp {
    NSDictionary *parameters = @{
                                 @"username": self.username,
                                 @"password": self.password,
                                 @"password_confirmation": self.password
                                 };
    NSString* url = [NSString stringWithFormat:@"%@/users/register", kMPServer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    return true;
}

- (BOOL)signUp:(NSError *)error {
    return false;
}

- (BOOL)signUpInBackground {
    return false;
}

- (void)signUpInBackgroundWithBlock:(MPBooleanResultBlock)block {
    
}


- (void)signUpInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

+ (instancetype)logInWithUsername:(NSString *)username
                         password:(NSString *)password {
    return nil;
}

+ (instancetype)logInWithUsername:(NSString *)username
                         password:(NSString *)password
                            error:(NSError **)error {
    return nil;
}

+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password {
    
}

+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                               target:(id)target
                             selector:(SEL)selector {
    
}

+ (void)logInWithUsernameInBackground:(NSString *)username
                             password:(NSString *)password
                                block:(MPUserResultBlock)block {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"username": username,@"password": password };
    NSString* url = [NSString stringWithFormat:@"%@/users/login", kMPServer];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MPUser *user = [MPUser user];
        user.sessionToken = [responseObject objectForKey:@"auth_token"];
        user.objectId = [[responseObject objectForKey:@"user"] objectForKey:@"user_id"];
        user.username = [[responseObject objectForKey:@"user"] objectForKey:@"user_name"];
        
        // TODO: save token to local cache
        block(user, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

/** @name Logging Out */

+ (void)logOut {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString* url = [NSString stringWithFormat:@"%@/users/logout", kMPServer];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}



@end
