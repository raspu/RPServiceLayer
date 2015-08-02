//
//  RPServiceProtocol.h
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import <Foundation/Foundation.h>

/**
 *  All classes conforming to this protocol will be trated as potential services by the Service Layer.
 */
@protocol RPServiceProtocol <NSObject>

@required
/**
 *  Should return YES if this class represents a service. You may return NO if is not a service, you can use this to decide if the App is going to have or nor a service on compilation time. Keep in mind that this is going to be asked only once at launch time.
 *
 *  @return BOOL
 */
+ (BOOL)isAService;

/**
 *  This will be used to identify the service in several places, and will also used as scheme for openURL: calls (For example, if your service is called "MyModule", you can send a message to it using this url "MyModule://methodA?parameterA=1&parameterB=2"). A valid identifier can only contain Alphanumeric characters.
 *
 *  @return NSString
 */
+ (NSString *)serviceIdentifier;

/**
 *  If the class return YES, all messages sent to this service will be dispatched on a custom concurrent queue synchronously, except for the selectors returned by writeSelectorStrings, that will dispatched barrier asynchronously on the same concurrent queue and for the selectors returned by ignoreSelectorStrings, that will be send directly. If returns NO, messages will be sent directly.
 *  Keep in mind that write operations with a return value will be executed synchronously, so try to avoid returning values in write operations. Also, any method declared by a super class will be called directly.
 *
 *  @return BOOL
 */
+ (BOOL)requiresThreadSafeExecution;

/**
 *  Only called if requiresThreadSafeExecution returns YES. Should return all selectors that do any kind of write operation on a mutable object.
 *
 *  @return NSArray of NSStrings with the selector names.
 */
+ (NSArray *)writeSelectorStrings;

/**
 *  Only called if requiresThreadSafeExecution returns YES. Should return all selectors that need to be executed directly and not dispatched into a queue.
 *
 *  @return NSArray of NSStrings with the selector names.
 */
+ (NSArray *)ignoreSelectorStrings;

@optional

@end
