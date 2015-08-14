//
//  RPServiceLayer.m
//  Pods
//
//  Created by Juan Pablo Illanes Sotta on 2/8/15.
//
//

#import "RPServiceLayer.h"
#import "RPAppDelegateProxy.h"
#import <objc/runtime.h>
#import "RPServiceProtocol.h"
#import "RPServiceProxy.h"

@interface RPServiceLayer ()
@property (nonatomic,strong) RPAppDelegateProxy *delegateProxy;
@property (nonatomic,strong) NSMutableDictionary *servicesProxies;
@property (nonatomic,readonly) NSSet *serviceClasses;

@end

@implementation RPServiceLayer

- (id)init
{
    self = [super init];
    if(self)
    {
        _servicesProxies = [NSMutableDictionary dictionary];
        [self findServices];
        [self startServices];
    }
    return self;
}

#pragma mark - Public methods
- (id)srv:(NSString *)service
{
    return [self.servicesProxies objectForKey:service];
}

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


#pragma mark - Operation

- (void)startServices
{
    NSMutableDictionary *services = (NSMutableDictionary *)self.servicesProxies;
    for (NSString *serviceClass in self.serviceClasses)
    {
        Class class = NSClassFromString(serviceClass);
        if([class isAService])
        {
            id<RPServiceProtocol> service = [[class alloc] init];
            if([service start])
            {
                RPServiceProxy *proxy = [[RPServiceProxy alloc] initWithServiceInstance:service];
                [services setObject:proxy forKey:proxy.serviceIdentifier];
            }

        }
    }
}

- (void)findServices
{
    Protocol *serviceProtocol = @protocol(RPServiceProtocol);
    NSMutableArray *serviceClasses = [NSMutableArray array];
    
    Class *classes = NULL;
    int numClasses = objc_getClassList(NULL, 0);;
    
    if (numClasses > 0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++)
        {
            Class class = classes[i];
            if (class_getClassMethod(class, @selector(conformsToProtocol:))  && class_conformsToProtocol(classes[i], serviceProtocol))
            {
                NSString *className = [NSString stringWithUTF8String:class_getName(class)];
                [serviceClasses addObject:className];
            }
        }
        free(classes);
    }
    _serviceClasses = [NSSet setWithArray:serviceClasses];
}

@end
