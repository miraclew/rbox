//
//  MPQuery.m
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import "MP.h"
#import "AFNetworking.h"

@implementation MPQuery {
    AFHTTPRequestOperationManager *manager;
    NSMutableArray *sorts;
    NSMutableDictionary *where;
}

+ (MPQuery *)queryWithClassName:(NSString *)className {
    return [[MPQuery alloc] initWithClassName:className];
}

/*!
 Creates a MPQuery with the constraints given by predicate.
 
 The following types of predicates are supported:
 * Simple comparisons such as =, !=, <, >, <=, >=, and BETWEEN with a key and a constant.
 * Containment predicates, such as "x IN {1, 2, 3}".
 * Key-existence predicates, such as "x IN SELF".
 * BEGINSWITH expressions.
 * Compound predicates with AND, OR, and NOT.
 * SubQueries with "key IN %@", subquery.
 
 The following types of predicates are NOT supported:
 * Aggregate operations, such as ANY, SOME, ALL, or NONE.
 * Regular expressions, such as LIKE, MATCHES, CONTAINS, or ENDSWITH.
 * Predicates comparing one key to another.
 * Complex predicates with many ORed clauses.
 
 */
+ (MPQuery *)queryWithClassName:(NSString *)className predicate:(NSPredicate *)predicate {
    return nil;
}

/*!
 Initializes the query with a class name.
 @param newClassName The class name.
 */
- (id)initWithClassName:(NSString *)newClassName {
    self = [super init];
    if (self) {
        self.mpClassName = newClassName;
        _limit = 20;
        _skip = 0;
        
        sorts = [[NSMutableArray alloc] init];
        where = [[NSMutableDictionary alloc] init];
        manager = [AFHTTPRequestOperationManager manager];
        [[manager requestSerializer] setValue:[MP getApplicationId] forHTTPHeaderField:@"AppId"];
    }
    return self;
}

- (void) reset
{
    [sorts removeAllObjects];
    [where removeAllObjects];
}

- (void)includeKey:(NSString *)key {
    
}

/*!
 Make the query restrict the fields of the returned MPObjects to include only the provided keys.
 If this is called multiple times, then all of the keys specified in each of the calls will be included.
 @param keys The keys to include in the result.
 */
- (void)selectKeys:(NSArray *)keys {
    
}

/*!
 Add a constraint that requires a particular key exists.
 @param key The key that should exist.
 */
- (void)whereKeyExists:(NSString *)key {
    
}

/*!
 Add a constraint that requires a key not exist.
 @param key The key that should not exist.
 */
- (void)whereKeyDoesNotExist:(NSString *)key {
    
}

/*!
 Add a constraint to the query that requires a particular key's object to be equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key equalTo:(id)object {
    [where setObject:object forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object to be less than the provided object.
 @param key The key to be constrained.
 @param object The object that provides an upper bound.
 */
- (void)whereKey:(NSString *)key lessThan:(id)object {
    [where setObject:@{@"$lt": object} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object to be less than or equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key lessThanOrEqualTo:(id)object {
    [where setObject:@{@"$lte": object} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object to be greater than the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key greaterThan:(id)object {
    [where setObject:@{@"$gt": object} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object to be greater than or equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must be equalled.
 */
- (void)whereKey:(NSString *)key greaterThanOrEqualTo:(id)object {
    [where setObject:@{@"$gte": object} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object to be not equal to the provided object.
 @param key The key to be constrained.
 @param object The object that must not be equalled.
 */
- (void)whereKey:(NSString *)key notEqualTo:(id)object {
    [where setObject:@{@"$ne": object} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object to be contained in the provided array.
 @param key The key to be constrained.
 @param array The possible values for the key's object.
 */
- (void)whereKey:(NSString *)key containedIn:(NSArray *)array {
    [where setObject:@{@"$in": array} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's object not be contained in the provided array.
 @param key The key to be constrained.
 @param array The list of values the key's object should not be.
 */
- (void)whereKey:(NSString *)key notContainedIn:(NSArray *)array {
    [where setObject:@{@"$nin": array} forKey:key];
}

/*!
 Add a constraint to the query that requires a particular key's array contains every element of the provided array.
 @param key The key to be constrained.
 @param array The array of values to search for.
 */
- (void)whereKey:(NSString *)key containsAllObjectsInArray:(NSArray *)array {
    [where setObject:@{@"$all": array} forKey:key];
}

/** @name Adding String Constraints */

/*!
 Add a regular expression constraint for finding string values that match the provided regular expression.
 This may be slow for large datasets.
 @param key The key that the string to match is stored in.
 @param regex The regular expression pattern to match.
 */
- (void)whereKey:(NSString *)key matchesRegex:(NSString *)regex {
    [where setObject:@{@"$all": regex} forKey:key];
}

/*!
 Add a regular expression constraint for finding string values that match the provided regular expression.
 This may be slow for large datasets.
 @param key The key that the string to match is stored in.
 @param regex The regular expression pattern to match.
 @param modifiers Any of the following supported PCRE modifiers:<br><code>i</code> - Case insensitive search<br><code>m</code> - Search across multiple lines of input
 */
- (void)whereKey:(NSString *)key matchesRegex:(NSString *)regex modifiers:(NSString *)modifiers {
    [where setObject:@{@"$regex": regex, @"$options": modifiers } forKey:key];
}

/*!
 Add a constraint for finding string values that contain a provided substring.
 This will be slow for large datasets.
 @param key The key that the string to match is stored in.
 @param substring The substring that the value must contain.
 */
- (void)whereKey:(NSString *)key containsString:(NSString *)substring {
    [where setObject:[NSString stringWithFormat:@"/%@/", substring] forKey:key];
}

/*!
 Add a constraint for finding string values that start with a provided prefix.
 This will use smart indexing, so it will be fast for large datasets.
 @param key The key that the string to match is stored in.
 @param prefix The substring that the value must start with.
 */
- (void)whereKey:(NSString *)key hasPrefix:(NSString *)prefix {
    [where setObject:[NSString stringWithFormat:@"/^%@/", prefix] forKey:key];
}

/*!
 Add a constraint for finding string values that end with a provided suffix.
 This will be slow for large datasets.
 @param key The key that the string to match is stored in.
 @param suffix The substring that the value must end with.
 */
- (void)whereKey:(NSString *)key hasSuffix:(NSString *)suffix {
    [where setObject:[NSString stringWithFormat:@"/%@^/", suffix] forKey:key];
}

/** @name Adding Subqueries */

/*!
 Returns a MPQuery that is the or of the passed in MPQuerys.
 @param queries The list of queries to or together.
 @result a MPQuery that is the or of the passed in MPQuerys.
 */
+ (MPQuery *)orQueryWithSubqueries:(NSArray *)queries {
    return nil;
}

/*!
 Adds a constraint that requires that a key's value matches a value in another key
 in objects returned by a sub query.
 @param key The key that the value is stored
 @param otherKey The key in objects in the returned by the sub query whose value should match
 @param query The query to run.
 */
- (void)whereKey:(NSString *)key matchesKey:(NSString *)otherKey inQuery:(MPQuery *)query {
    
}

/*!
 Adds a constraint that requires that a key's value NOT match a value in another key
 in objects returned by a sub query.
 @param key The key that the value is stored
 @param otherKey The key in objects in the returned by the sub query whose value should match
 @param query The query to run.
 */
- (void)whereKey:(NSString *)key doesNotMatchKey:(NSString *)otherKey inQuery:(MPQuery *)query {
    
}

/*!
 Add a constraint that requires that a key's value matches a MPQuery constraint.
 This only works where the key's values are MPObjects or arrays of MPObjects.
 @param key The key that the value is stored in
 @param query The query the value should match
 */
- (void)whereKey:(NSString *)key matchesQuery:(MPQuery *)query {
    
}

/*!
 Add a constraint that requires that a key's value to not match a MPQuery constraint.
 This only works where the key's values are MPObjects or arrays of MPObjects.
 @param key The key that the value is stored in
 @param query The query the value should not match
 */
- (void)whereKey:(NSString *)key doesNotMatchQuery:(MPQuery *)query {
    
}

#pragma mark -
#pragma mark Sorting

/** @name Sorting */

/*!
 Sort the results in ascending order with the given key.
 @param key The key to order by.
 */
- (void)orderByAscending:(NSString *)key {
    [sorts removeAllObjects];
    [self addAscendingOrder:key];
}

/*!
 Also sort in ascending order by the given key.  The previous keys provided will
 precedence over this key.
 @param key The key to order bye
 */
- (void)addAscendingOrder:(NSString *)key {
    [sorts addObject:@[key, @"asc"]];
}

/*!
 Sort the results in descending order with the given key.
 @param key The key to order by.
 */
- (void)orderByDescending:(NSString *)key {
    [sorts removeAllObjects];
    [self addDescendingOrder:key];
}
/*!
 Also sort in descending order by the given key.  The previous keys provided will
 precedence over this key.
 @param key The key to order bye
 */
- (void)addDescendingOrder:(NSString *)key {
    [sorts addObject:@[key, @"desc"]];
}

/*!
 Sort the results in descending order with the given descriptor.
 @param sortDescriptor The NSSortDescriptor to order by.
 */
- (void)orderBySortDescriptor:(NSSortDescriptor *)sortDescriptor {
    
}

/*!
 Sort the results in descending order with the given descriptors.
 @param sortDescriptors An NSArray of NSSortDescriptor instances to order by.
 */
- (void)orderBySortDescriptors:(NSArray *)sortDescriptors {
    
}

#pragma mark -
#pragma mark Get methods

/** @name Getting Objects by ID */

/*!
 Returns a MPObject with a given class and id.
 @param objectClass The class name for the object that is being requested.
 @param objectId The id of the object that is being requested.
 @result The MPObject if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (MPObject *)getObjectOfClass:(NSString *)objectClass
                      objectId:(NSString *)objectId {
    return nil;
}

/*!
 Returns a MPObject with a given class and id and sets an error if necessary.
 @param error Pointer to an NSError that will be set if necessary.
 @result The MPObject if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (MPObject *)getObjectOfClass:(NSString *)objectClass
                      objectId:(NSString *)objectId
                         error:(NSError **)error {
    return nil;
}

/*!
 Returns a MPObject with the given id.
 
 This mutates the MPQuery.
 
 @param objectId The id of the object that is being requested.
 @result The MPObject if found. Returns nil if the object isn't found, or if there was an error.
 */
- (MPObject *)getObjectWithId:(NSString *)objectId {
    return nil;
}

/*!
 Returns a MPObject with the given id and sets an error if necessary.
 
 This mutates the MPQuery
 
 @param error Pointer to an NSError that will be set if necessary.
 @result The MPObject if found. Returns nil if the object isn't found, or if there was an error.
 */
- (MPObject *)getObjectWithId:(NSString *)objectId error:(NSError **)error {
    return nil;
}

/*!
 Gets a MPObject asynchronously and calls the given block with the result.
 
 This mutates the MPQuery
 
 @param block The block to execute. The block should have the following argument signature: (NSArray *object, NSError *error)
 */
- (void)getObjectInBackgroundWithId:(NSString *)objectId
                              block:(MPObjectResultBlock)block {
    NSString* url = [NSString stringWithFormat:@"%@/stores/%@/%@", kMPServer, self.mpClassName, objectId];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        MPObject *object = [MPObject objectWithClassName:self.mpClassName dictionary: [responseObject objectForKey:@"object"]];
        if (block != nil) {
            block(object, nil);
        }
        
        [self reset];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block != nil) {
            block(nil, error);
        }
        
        [self reset];
    }];
}

/*!
 Gets a MPObject asynchronously.
 
 This mutates the MPQuery
 
 @param objectId The id of the object being requested.
 @param target The target for the callback selector.
 @param selector The selector for the callback. It should have the following signature: (void)callbackWithResult:(MPObject *)result error:(NSError *)error. result will be nil if error is set and vice versa.
 */
- (void)getObjectInBackgroundWithId:(NSString *)objectId
                             target:(id)target
                           selector:(SEL)selector {
    
}

#pragma mark -
#pragma mark Getting Users

/*! @name Getting User Objects */

/*!
 Returns a MPUser with a given id.
 @param objectId The id of the object that is being requested.
 @result The MPUser if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (MPUser *)getUserObjectWithId:(NSString *)objectId {
    return nil;
}

/*!
 Returns a MPUser with a given class and id and sets an error if necessary.
 @param error Pointer to an NSError that will be set if necessary.
 @result The MPUser if found. Returns nil if the object isn't found, or if there was an error.
 */
+ (MPUser *)getUserObjectWithId:(NSString *)objectId
                          error:(NSError **)error {
    return nil;
}

/*!
 Deprecated.  Please use [MPUser query] instead.
 */
+ (MPQuery *)queryForUser __attribute__ ((deprecated)) {
    return nil;
}

#pragma mark -
#pragma mark Find methods

/** @name Getting all Matches for a Query */

/*!
 Finds objects based on the constructed query.
 @result Returns an array of MPObjects that were found.
 */
- (NSArray *)findObjects {
    return nil;
}

/*!
 Finds objects based on the constructed query and sets an error if there was one.
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns an array of MPObjects that were found.
 */
- (NSArray *)findObjects:(NSError **)error {
    return nil;
}

/*!
 Finds objects asynchronously and calls the given block with the results.
 @param block The block to execute. The block should have the following argument signature:(NSArray *objects, NSError *error)
 */
- (void)findObjectsInBackgroundWithBlock:(MPArrayResultBlock)block {
    NSString* url = [NSString stringWithFormat:@"%@/stores/%@", kMPServer, self.mpClassName];
    
    NSMutableDictionary *parameters = [@{ @"limit": @(_limit), @"skip": @(_skip) } mutableCopy];
    if ([sorts count] > 0) {
        NSError *error;
        NSData *registerData = [NSJSONSerialization dataWithJSONObject:sorts options:NSJSONWritingPrettyPrinted error:&error];
        NSString * ss = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
        NSLog(@"sort:%@",ss);
        [parameters setObject:ss forKey:@"sort"];
    }
    if ([where count] > 0) {
        NSError *error;
        NSData *rData = [NSJSONSerialization dataWithJSONObject:where options:NSJSONWritingPrettyPrinted error:&error];
        NSString * whereJSON = [[NSString alloc] initWithData:rData encoding:NSUTF8StringEncoding];
        NSLog(@"where:%@",whereJSON);
        [parameters setObject:whereJSON forKey:@"where"];
    }
    
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *resObjects = [responseObject objectForKey:@"objects"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *item in resObjects) {
            [array addObject:[MPObject objectWithClassName:self.mpClassName dictionary:item]];
        }
        
        if (block != nil) {
            block(array, nil);
        }
        
        [self reset];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block != nil) {
            block(nil, error);
        }
        
        [self reset];
    }];

}

/*!
 Finds objects asynchronously and calls the given callback with the results.
 @param target The object to call the selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSArray *)result error:(NSError *)error. result will be nil if error is set and vice versa.
 */
- (void)findObjectsInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

/** @name Getting the First Match in a Query */

/*!
 Gets an object based on the constructed query.
 
 This mutates the MPQuery.
 
 @result Returns a MPObject, or nil if none was found.
 */
- (MPObject *)getFirstObject {
    return nil;
}

/*!
 Gets an object based on the constructed query and sets an error if any occurred.
 
 This mutates the MPQuery.
 
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns a MPObject, or nil if none was found.
 */
- (MPObject *)getFirstObject:(NSError **)error {
    return nil;
}

/*!
 Gets an object asynchronously and calls the given block with the result.
 
 This mutates the MPQuery.
 
 @param block The block to execute. The block should have the following argument signature:(MPObject *object, NSError *error) result will be nil if error is set OR no object was found matching the query. error will be nil if result is set OR if the query succeeded, but found no results.
 */
- (void)getFirstObjectInBackgroundWithBlock:(MPObjectResultBlock)block {
}

/*!
 Gets an object asynchronously and calls the given callback with the results.
 
 This mutates the MPQuery.
 
 @param target The object to call the selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(MPObject *)result error:(NSError *)error. result will be nil if error is set OR no object was found matching the query. error will be nil if result is set OR if the query succeeded, but found no results.
 */
- (void)getFirstObjectInBackgroundWithTarget:(id)target selector:(SEL)selector {
}

#pragma mark -
#pragma mark Count methods

/** @name Counting the Matches in a Query */

/*!
 Counts objects based on the constructed query.
 @result Returns the number of MPObjects that match the query, or -1 if there is an error.
 */
- (NSInteger)countObjects {
    return 0;
}

/*!
 Counts objects based on the constructed query and sets an error if there was one.
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns the number of MPObjects that match the query, or -1 if there is an error.
 */
- (NSInteger)countObjects:(NSError **)error {
    return 0;
}

/*!
 Counts objects asynchronously and calls the given block with the counts.
 @param block The block to execute. The block should have the following argument signature:
 (int count, NSError *error)
 */
- (void)countObjectsInBackgroundWithBlock:(MPIntegerResultBlock)block {
    
}

/*!
 Counts objects asynchronously and calls the given callback with the count.
 @param target The object to call the selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSNumber *)result error:(NSError *)error. */
- (void)countObjectsInBackgroundWithTarget:(id)target selector:(SEL)selector {
    
}

#pragma mark -
#pragma mark Cancel methods

/** @name Cancelling a Query */

/*!
 Cancels the current network request (if any). Ensures that callbacks won't be called.
 */
- (void)cancel {
    
}

#pragma mark -
#pragma mark Pagination properties

/** @name Paginating Results */
#pragma mark -
#pragma mark Cache methods

/** @name Controlling Caching Behavior */

/*!
 Returns whether there is a cached result for this query.
 @result YES if there is a cached result for this query, and NO otherwise.
 */
- (BOOL)hasCachedResult {
    return NO;
}

/*!
 Clears the cached result for this query.  If there is no cached result, this is a noop.
 */
- (void)clearCachedResult {
    
}

/*!
 Clears the cached results for all queries.
 */
+ (void)clearAllCachedResults {
    
}

@end
