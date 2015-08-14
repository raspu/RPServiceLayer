//
//  RPTestService.h
//  RPServiceLayer
//
//  Created by Juan Pablo Illanes Sotta on 14/8/15.
//  Copyright (c) 2015 J.P. Illanes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RPServiceLayer/RPServiceProtocol.h>

@interface RPTestService : NSObject <RPServiceProtocol>
- (void)testWrite:(void (^)())callback;
- (NSInteger)testRead;
@end
