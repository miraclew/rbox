//
//  MPObject.m
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MP.h"
#import "AFNetworking.h"

@implementation MPObject {
    NSMutableDictionary *_attributes;
    AFHTTPRequestOperationManager *manager;
}

+ (instancetype)objectWithClassName:(NSString *)className {
    return [[MPObject alloc] initWithClassName:className dictionary:nil];
}

+ (instancetype)objectWithoutDataWithClassName:(NSString *)className
                                      objectId:(NSString *)objectId {
    return nil;
}

+ (MPObject *)objectWithClassName:(NSString *)className dictionary:(NSDictionary *)dictionary {
    return [[MPObject alloc] initWithClassName:className dictionary:dictionary];
}

- (id) initWithClassName:(NSString *)newClassName dictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self != nil) {
        _mpClassName = newClassName;
        if (dictionary != nil) {
            _attributes = [dictionary mutableCopy];
            _objectId = [_attributes objectForKey:@"id"];
        } else {
            _attributes = [[NSMutableDictionary alloc] init];
        }
        
        manager = [AFHTTPRequestOperationManager manager];
        [[manager requestSerializer] setValue:[MP getApplicationId] forHTTPHeaderField:@"AppId"];
    }
    
    return self;
}

-(id) initWithClassName:(NSString *)newClassName {
    return [self initWithClassName:newClassName dictionary:nil];
}

#pragma mark -
#pragma mark Properties

/*!
 Returns an array of the keys contained in this object. This does not include
 createdAt, updatedAt, authData, or objectId. It does include things like username
 and ACL.
 */
- (NSArray *)allKeys {
    return nil;
}


#pragma mark -
#pragma mark Get and set

- (id)objectForKey:(NSString *)key {
    return [_attributes objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key {
    [_attributes setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [_attributes removeObjectForKey:key];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [_attributes objectForKeyedSubscript:key];
}

- (void)setObject:(id)object forKeyedSubscript:(NSString *)key {
    [_attributes setObject:object forKeyedSubscript:key];
}

- (MPRelation *)relationForKey:(NSString *)key {
        return nil;
}

- (MPRelation *)relationforKey:(NSString *)key {
        return nil;
}

#pragma mark -
#pragma mark Array add and remove

- (void)addObject:(id)object forKey:(NSString *)key {
    
}

- (void)addObjectsFromArray:(NSArray *)objects forKey:(NSString *)key {
    
}

- (void)addUniqueObject:(id)object forKey:(NSString *)key {
    
}

- (void)addUniqueObjectsFromArray:(NSArray *)objects forKey:(NSString *)key {
    
}

- (void)removeObject:(id)object forKey:(NSString *)key {
    
}

- (void)removeObjectsInArray:(NSArray *)objects forKey:(NSString *)key {
    
}

#pragma mark -
#pragma mark Increment

- (void)incrementKey:(NSString *)key {
    
}

- (void)incrementKey:(NSString *)key byAmount:(NSNumber *)amount {
    
}

#pragma mark -
#pragma mark Save

/*! @name Saving an Object to Parse */

- (BOOL)save {
    return NO;
}

- (BOOL)save:(NSError **)error {
    return NO;
}

- (void)saveInBackground {
    [self saveInBackgroundWithBlock:nil];
}

- (void)saveInBackgroundWithBlock:(MPBooleanResultBlock)block {
    NSDictionary *parameters = @{ self.mpClassName: _attributes };
    NSString* url = [NSString stringWithFormat:@"%@/stores/%@", kMPServer, self.mpClassName];
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block != nil) {
            block(YES, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block != nil) {
            block(NO, error);
        }
    }];
}

- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

- (void)saveEventually {
    
}

- (void)saveEventually:(MPBooleanResultBlock)callback {
    
}

#pragma mark -
#pragma mark Save All

/*! @name Saving Many Objects to Parse */

+ (BOOL)saveAll:(NSArray *)objects {
    return NO;
}

+ (BOOL)saveAll:(NSArray *)objects error:(NSError **)error {
    return NO;
}

+ (void)saveAllInBackground:(NSArray *)objects {
    
}

+ (void)saveAllInBackground:(NSArray *)objects
                      block:(MPBooleanResultBlock)block {
    
}

+ (void)saveAllInBackground:(NSArray *)objects
                     target:(id)target
                   selector:(SEL)selector {
    
}

#pragma mark -
#pragma mark Delete All

/*! @name Delete Many Objects from Parse */

+ (BOOL)deleteAll:(NSArray *)objects {
    return NO;
}

+ (BOOL)deleteAll:(NSArray *)objects error:(NSError **)error {
    return NO;
}

+ (void)deleteAllInBackground:(NSArray *)objects {
    
}

+ (void)deleteAllInBackground:(NSArray *)objects
                        block:(MPBooleanResultBlock)block {
    
}

+ (void)deleteAllInBackground:(NSArray *)objects
                       target:(id)target
                     selector:(SEL)selector {
    
}

#pragma mark -
#pragma mark Refresh

/*! @name Getting an Object from Parse */

- (BOOL)isDataAvailable {
    return NO;
}

- (void)fetch {
    
}

- (void)fetch:(NSError **)error {
    
}

- (MPObject *)fetchIfNeeded {
    return nil;
}

- (MPObject *)fetchIfNeeded:(NSError **)error {
    return nil;
}

- (void)fetchInBackgroundWithBlock:(MPObjectResultBlock)block {
    
}

- (void)fetchInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

- (void)fetchIfNeededInBackgroundWithBlock:(MPObjectResultBlock)block {
    
}

- (void)fetchIfNeededInBackgroundWithTarget:(id)target
                                   selector:(SEL)selector {
    
}

+ (void)fetchAll:(NSArray *)objects {
    
}

+ (void)fetchAll:(NSArray *)objects error:(NSError **)error {
    
}

+ (void)fetchAllIfNeeded:(NSArray *)objects {
    
}

+ (void)fetchAllIfNeeded:(NSArray *)objects error:(NSError **)error {
    
}

+ (void)fetchAllInBackground:(NSArray *)objects
                       block:(MPArrayResultBlock)block {
    
}

+ (void)fetchAllInBackground:(NSArray *)objects
                      target:(id)target
                    selector:(SEL)selector {
    
}

+ (void)fetchAllIfNeededInBackground:(NSArray *)objects
                               block:(MPArrayResultBlock)block {
    
}

+ (void)fetchAllIfNeededInBackground:(NSArray *)objects
                              target:(id)target
                            selector:(SEL)selector {
    
}

#pragma mark -
#pragma mark Delete

/*! @name Removing an Object from Parse */

/*!
 Deletes the MPObject.
 @result Returns whether the delete succeeded.
 */
- (BOOL)delete {
 return NO;
}

/*!
 Deletes the MPObject and sets an error if it occurs.
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns whether the delete succeeded.
 */
- (BOOL)delete:(NSError **)error {
 return NO;
}

/*!
 Deletes the MPObject asynchronously.
 */
- (void)deleteInBackground {
    
}

/*!
 Deletes the MPObject asynchronously and executes the given callback block.
 @param block The block to execute. The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)deleteInBackgroundWithBlock:(MPBooleanResultBlock)block {
    
}

/*!
 Deletes the MPObject asynchronously and calls the given callback.
 @param target The object to call selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSNumber *)result error:(NSError *)error. error will be nil on success and set if there was an error. [result boolValue] will tell you whether the call succeeded or not.
 */
- (void)deleteInBackgroundWithTarget:(id)target
                            selector:(SEL)selector {
    
}

/*!
 Deletes this object from the server at some unspecified time in the future, even if Parse is currently inaccessible.
 Use this when you may not have a solid network connection, and don't need to know when the delete completes.
 If there is some problem with the object such that it can't be deleted, the request will be silently discarded.
 
 Delete instructions made with this method will be stored locally in an on-disk cache until they can be transmitted
 to Parse. They will be sent immediately if possible.  Otherwise, they will be sent the next time a network connection
 is available. Delete requests will persist even after the app is closed, in which case they will be sent the
 next time the app is opened.  If more than 10MB of saveEventually or deleteEventually commands are waiting to be sent,
 subsequent calls to saveEventually or deleteEventually will cause old requests to be silently discarded until the
 connection can be re-established, and the queued requests can go through.
 */
- (void)deleteEventually {
    
}

#pragma mark -
#pragma Dirtiness

/*!
 Gets whether any key-value pair in this object (or its children) has been added/updated/removed and not saved yet.
 @result Returns whether this object has been altered and not saved yet.
 */
- (BOOL)isDirty {
    return NO;
}

/*!
 Get whether a value associated with a key has been added/updated/removed and not saved yet.
 @param key The key to check for
 @result Returns whether this key has been altered and not saved yet.
 */
- (BOOL)isDirtyForKey:(NSString *)key {
    return NO;
}


@end
