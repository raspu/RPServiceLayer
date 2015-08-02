//
//  RPAppDelegateProxy.m
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import "RPAppDelegateProxy.h"


@implementation RPAppDelegateProxy


- (instancetype)initWithAppDelegate:(id<UIApplicationDelegate>)appDelegate
{
    NSParameterAssert(appDelegate);
    _appDelegate = appDelegate;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [(NSObject *)self.appDelegate methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    //Let's call the real appDelegate immediately
    [invocation invokeWithTarget:self.appDelegate];
    
    //Call the services, if any answer this methods.

}

@end
