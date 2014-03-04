//
//  MMPile.h
//  MPSDK
//
//  Created by Wan Wei on 14-2-25.
//  Copyright (c) 2014年 Wan Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPConstants.h"

/*!
 A file of binary data stored on the Parse servers. This can be a image, video, or anything else
 that an application needs to reference in a non-relational way.
 */
@interface MPFile : NSObject

/** @name Creating a MMPile */

/*!
 Creates a file with given data. A name will be assigned to it by the server.
 @param data The contents of the new MMPile.
 @result A MMPile.
 */
+ (id)fileWithData:(NSData *)data;

/*!
 Creates a file with given data and name.
 @param name The name of the new MMPile. The file name must begin with and
 alphanumeric character, and consist of alphanumeric characters, periods,
 spaces, underscores, or dashes.
 @param data The contents of hte new MMPile.
 @result A MMPile.
 */
+ (id)fileWithName:(NSString *)name data:(NSData *)data;

/*!
 Creates a file with the contents of another file.
 @param name The name of the new MPFile. The file name must begin with and
 alphanumeric character, and consist of alphanumeric characters, periods,
 spaces, underscores, or dashes.
 @param path The path to the file that will be uploaded to Cloud
 */
+ (id)fileWithName:(NSString *)name
    contentsAtPath:(NSString *)path;

/*!
 The name of the file. Before save is called, this is the filename given by
 the user. After save is called, that name gets prefixed with a unique
 identifier.
 */
@property (assign, readonly) NSString *name;

/*!
 The url of the file.
 */
@property (assign, readonly) NSString *url;

/** @name Storing Data with Parse */

/*!
 Whether the file has been uploaded for the first time.
 */
@property (readonly) BOOL isDirty;

/*!
 Saves the file.
 @result Returns whether the save succeeded.
 */
- (BOOL)save;

/*!
 Saves the file and sets an error if it occurs.
 @param error Pointer to an NSError that will be set if necessary.
 @result Returns whether the save succeeded.
 */
- (BOOL)save:(NSError **)error;

/*!
 Saves the file asynchronously.
 */
- (void)saveInBackground;

/*!
 Saves the file asynchronously and executes the given block.
 @param block The block should have the following argument signature: (BOOL succeeded, NSError *error)
 */
- (void)saveInBackgroundWithBlock:(MPBooleanResultBlock)block;

/*!
 Saves the file asynchronously and executes the given resultBlock. Executes the progressBlock periodically with the percent
 progress. progressBlock will get called with 100 before resultBlock is called.
 @param block The block should have the following argument signature: (BOOL succeeded, NSError *error)
 @param progressBlock The block should have the following argument signature: (int percentDone)
 */
- (void)saveInBackgroundWithBlock:(MPBooleanResultBlock)block
                    progressBlock:(MPProgressBlock)progressBlock;

/*!
 Saves the file asynchronously and calls the given callback.
 @param target The object to call selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSNumber *)result error:(NSError *)error. error will be nil on success and set if there was an error. [result boolValue] will tell you whether the call succeeded or not.
 */
- (void)saveInBackgroundWithTarget:(id)target selector:(SEL)selector;

/** @name Getting Data from Parse */

/*!
 Whether the data is available in memory or needs to be downloaded.
 */
@property (readonly) BOOL isDataAvailable;

/*!
 Gets the data from cache if available or fetches its contents from the Parse
 servers.
 @result The data. Returns nil if there was an error in fetching.
 */
- (NSData *)getData;

/*!
 This method is like getData but avoids ever holding the entire MMPile's
 contents in memory at once. This can help applications with many large MMPiles
 avoid memory warnings.
 @result A stream containing the data. Returns nil if there was an error in
 fetching.
 */
- (NSInputStream *)getDataStream;

/*!
 Gets the data from cache if available or fetches its contents from the Parse
 servers. Sets an error if it occurs.
 @param error Pointer to an NSError that will be set if necessary.
 @result The data. Returns nil if there was an error in fetching.
 */
- (NSData *)getData:(NSError **)error;

/*!
 This method is like getData: but avoids ever holding the entire MMPile's
 contents in memory at once. This can help applications with many large MMPiles
 avoid memory warnings. Sets an error if it occurs.
 @param error Pointer to an NSError that will be set if necessary.
 @result A stream containing the data. Returns nil if there was an error in
 fetching.
 */
- (NSInputStream *)getDataStream:(NSError **)error;

/*!
 Asynchronously gets the data from cache if available or fetches its contents
 from the Parse servers. Executes the given block.
 @param block The block should have the following argument signature: (NSData *result, NSError *error)
 */
- (void)getDataInBackgroundWithBlock:(MPDataResultBlock)block;

/*!
 This method is like getDataInBackgroundWithBlock: but avoids ever holding the
 entire MMPile's contents in memory at once. This can help applications with
 many large MMPiles avoid memory warnings.
 @param block The block should have the following argument signature: (NSInputStream *result, NSError *error)
 */
- (void)getDataStreamInBackgroundWithBlock:(MPDataStreamResultBlock)block;

/*!
 Asynchronously gets the data from cache if available or fetches its contents
 from the Parse servers. Executes the resultBlock upon
 completion or error. Executes the progressBlock periodically with the percent progress. progressBlock will get called with 100 before resultBlock is called.
 @param resultBlock The block should have the following argument signature: (NSData *result, NSError *error)
 @param progressBlock The block should have the following argument signature: (int percentDone)
 */
- (void)getDataInBackgroundWithBlock:(MPDataResultBlock)resultBlock
                       progressBlock:(MPProgressBlock)progressBlock;

/*!
 This method is like getDataInBackgroundWithBlock:progressBlock: but avoids ever
 holding the entire MMPile's contents in memory at once. This can help
 applications with many large MMPiles avoid memory warnings.
 @param resultBlock The block should have the following argument signature: (NSInputStream *result, NSError *error)
 @param progressBlock The block should have the following argument signature: (int percentDone)
 */
- (void)getDataStreamInBackgroundWithBlock:(MPDataStreamResultBlock)resultBlock
                             progressBlock:(MPProgressBlock)progressBlock;

/*!
 Asynchronously gets the data from cache if available or fetches its contents
 from the Parse servers.
 @param target The object to call selector on.
 @param selector The selector to call. It should have the following signature: (void)callbackWithResult:(NSData *)result error:(NSError *)error. error will be nil on success and set if there was an error.
 */
- (void)getDataInBackgroundWithTarget:(id)target selector:(SEL)selector;

/** @name Interrupting a Transfer */

/*!
 Cancels the current request (whether upload or download of file data).
 */
- (void)cancel;

@end
