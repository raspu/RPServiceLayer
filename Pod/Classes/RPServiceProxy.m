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
@property (nonatomic,readonly) NSSet *writeSelectors;
@property (nonatomic,readonly) NSSet *ignoreSelectors;

@end

@implementation RPServiceProxy

- (instancetype)initWithServiceInstance:(id<RPServiceProtocol>)service
{
    Class serviceClass = [service class];
    
    _service = service;
    _threadSafe = [serviceClass requiresThreadSafeExecution];
    _serviceIdentifier = [[serviceClass serviceIdentifier] copy];
    
    if(_threadSafe)
    {
        NSString *queueName = [NSString stringWithFormat:@"com.rpServiceLayer.serviceDispatch.%@",[[service class] serviceIdentifier]];
        _dispatchQueue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);
        
        if([serviceClass respondsToSelector:@selector(writeSelectorStrings)])
        {
            _writeSelectors = [NSSet setWithArray:[serviceClass writeSelectorStrings]];
        }
        
        if([serviceClass respondsToSelector:@selector(ignoreSelectorStrings)])
        {
            _ignoreSelectors = [NSSet setWithArray:[serviceClass ignoreSelectorStrings]];
        }
    }
    
    return self;
}

#pragma mark - Equality

- (BOOL)isEqual:(id)object
{
    return self == object; //Same as hash, this is good enough!
}

- (NSUInteger)hash
{
    return (NSUInteger)self; //Just the default implementation, we will only have one instance per service, so this will be fast and reliable.
}

#pragma mark - Protocols

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [self.service conformsToProtocol:aProtocol];
}


#pragma mark - Messaging

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    //If we are not trying to make it thread safe, we just forward the message.
    if(!self.threadSafe)
    {
        return self.service;
    }
    
    NSString *selectorString = NSStringFromSelector(aSelector);
    if([_ignoreSelectors containsObject:selectorString])
    {
        return self.service;
    }
    
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [(NSObject *)self.service methodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    //Now, if we are... 
    void (^execBlock)() = ^
    {
        [invocation invokeWithTarget:self.service];
    };
    
    NSString *selectorString = NSStringFromSelector([invocation selector]);
    NSString *returnType = [NSString stringWithUTF8String:[[invocation methodSignature] methodReturnType]];
    
    if([_writeSelectors containsObject:selectorString])
    {
        if([returnType isEqualToString:@"v"]) // If the returning type is void, let's proceed async
        {
            dispatch_barrier_async(self.dispatchQueue, execBlock);
        }else // If the returning type is not void, we must go sync! This is dangerous
        {
            dispatch_barrier_sync(self.dispatchQueue, execBlock);
        }
        
    }else
    {
        if([returnType isEqualToString:@"v"]) // If the returning type is void, let's proceed async
        {
            dispatch_async(self.dispatchQueue, execBlock);
        }else
        {
            dispatch_sync(self.dispatchQueue, execBlock);
        }
    }
    
    
}

@end
