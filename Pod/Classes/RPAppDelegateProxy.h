//
//  RPAppDelegateProxy.h
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import <Foundation/Foundation.h>


/**
 *  This proxy will send an equivalent message to the message received from the AppDelegate to all the responding instances.
 */
@interface RPAppDelegateProxy : NSProxy<UIApplicationDelegate>

/**
 *  The real Application delegate
 */
@property (nonatomic, assign, readonly) id<UIApplicationDelegate> appDelegate;

/**
 *  Inits the proxy for the given AppDelegate class.
 *
 *  @param appDelegate This should be the UIApplication delegate's.
 *
 *  @return RPAppDelegateProxy
 */
- (instancetype)initWithAppDelegate:(id<UIApplicationDelegate>)appDelegate;

@end
