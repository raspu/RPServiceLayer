//
//  RPViewController.m
//  RPServiceLayer
//
//  Created by J.P. Illanes on 08/02/2015.
//  Copyright (c) 2015 J.P. Illanes. All rights reserved.
//

#import "RPViewController.h"
#import <RPServiceLayer/RPServiceLayer.h>
#import "RPTestService.h"

@interface RPViewController ()

@end

@implementation RPViewController

- (void)loadView
{
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)openURL
{
    RPServiceLayer *appDelegate = (RPServiceLayer *)[UIApplication sharedApplication];
    [appDelegate openURL:[NSURL URLWithString:@"srv://test"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        for (int i = 0; i<100; i++)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSInteger read = [[appDelegate srv:@"test"] testRead];
                NSLog(@"Read: %i", read);
            });
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i<100; i++)
        {
            [[appDelegate srv:@"test"] testWrite:^()
             {
                 NSLog(@"Write %i", i);
             }];
            
        }
    });
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Sample
    UIButton *buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonA setTitle:@"Button A" forState:UIControlStateNormal];
    buttonA.frame = CGRectMake(10, 100, 100, 30);
    [buttonA addTarget:self action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buttonB = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonB setTitle:@"Button B" forState:UIControlStateNormal];
    buttonB.frame = CGRectMake(10, 160, 100, 30);
    
    [self.view addSubview:buttonA];
    [self.view addSubview:buttonB];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
