//
//  RPTestService.m
//  RPServiceLayer
//
//  Created by Juan Pablo Illanes Sotta on 14/8/15.
//  Copyright (c) 2015 J.P. Illanes. All rights reserved.
//

#import "RPTestService.h"

@interface RPTestService ()
@property (nonatomic) NSInteger count;
@end

@implementation RPTestService

+ (BOOL)isAService
{
    return YES;
}

+ (NSString *)serviceIdentifier
{
    return @"test";
}

+ (BOOL)requiresThreadSafeExecution
{
    return YES;
}

+ (NSArray *)writeSelectorStrings
{
    return @[@"testWrite:"];
}

- (BOOL)start
{
    return YES;
}

- (void)testWrite:(void (^)())callback
{
    self.count++;
    callback();
}

- (NSInteger)testRead
{
    return self.count;
}

@end
