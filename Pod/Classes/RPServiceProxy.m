//
//  RPServiceProxy.m
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import "RPServiceProxy.h"

@interface RPServiceProxy ()
@property (nonatomic) dispatch_queue_t dispatchQueue;
@end

@implementation RPServiceProxy

- (instancetype)initWithServiceInstance:(id<RPServiceProtocol>)service andMakeItThreadSafe:(BOOL)threadSafe
{
    _service = service;
    _threadSafe = threadSafe;
    
    NSString *queueName = [NSString stringWithFormat:@"com.rpServiceLayer.serviceDispatch.%@",[[service class] serviceIdentifier]];
    _dispatchQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);
    
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [(NSObject *)self.service methodSignatureForSelector:selector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    //If we are not trying to make it thread safe, we just forward the message.
    return (!self.threadSafe) ? self.service : nil;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    //Now, if we are... 
    void (^execBlock)() = ^
    {
        [invocation invokeWithTarget:self.service];
    };
    
    NSString *returnType = [NSString stringWithUTF8String:[[invocation methodSignature] methodReturnType]];
    
    //TODO: Make the logic more complex here, depending on what the service has configured...
    if([returnType isEqualToString:@"v"])
    {
        dispatch_async(self.dispatchQueue, execBlock);
    }else
    {
        dispatch_sync(self.dispatchQueue, execBlock);
    }
}

@end
