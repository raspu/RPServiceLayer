//
//  RPServiceLayer.m
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import "RPServiceLayer.h"
#import "RPAppDelegateProxy.h"


@interface RPServiceLayer ()
@property (nonatomic,strong) RPAppDelegateProxy *delegateProxy;
@property (nonatomic,strong) NSDictionary *servicesProxies;

@end

@implementation RPServiceLayer

#pragma mark - Delegate Mangement
- (void)setDelegate:(id<UIApplicationDelegate>)delegate
{
    self.delegateProxy = [[RPAppDelegateProxy alloc] initWithAppDelegate:delegate];
    [super setDelegate:self.delegateProxy];
}


#pragma mark - Overridden methods
- (BOOL)canOpenURL:(NSURL *)url
{
    if([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"])
        return [super canOpenURL:url];
    
    return [super canOpenURL:url];
}

- (BOOL)openURL:(NSURL *)url
{
    if([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"])
        return [super openURL:url];
    
    return [super openURL:url];
}

@end
