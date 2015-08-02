//
//  RPServiceProxy.h
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import <Foundation/Foundation.h>
#import "RPServiceProtocol.h"

@interface RPServiceProxy : NSProxy
@property (nonatomic,strong,readonly) id<RPServiceProtocol>     service;
@property (nonatomic,readonly) BOOL                             threadSafe;

/**
 *  Will init the proxy with the given service, and will configure it to make calls to it thread safe or not.
 *
 *  @param service    An object that conforms to RPServiceProtocol.
 *  @param threadSafe If YES all executions will be dispatched to a custom queue. if NO all messages will be sent direclty (fast forwarding). For more details see RPServiceProtocol documentation.
 *
 *  @return RPServiceProxy instance
 */
- (instancetype)initWithServiceInstance:(id<RPServiceProtocol>)service andMakeItThreadSafe:(BOOL)threadSafe;

@end
