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
@property (nonatomic,readonly) id<RPServiceProtocol>            service;
@property (nonatomic,readonly) NSString                         *serviceIdentifier;
@property (nonatomic,readonly) BOOL                             threadSafe;

/**
 *  Will init the proxy with the given service, and will configure it to make calls to it thread safe or not, depending of the service. For more information read RPServiceProtocol documentation.
 *
 *  @param service    An object that conforms to RPServiceProtocol.
 *
 *  @return RPServiceProxy instance
 */
- (instancetype)initWithServiceInstance:(id<RPServiceProtocol>)service;

@end
