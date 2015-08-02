//
//  RPViewController.m
//  RPServiceLayer
//
//  Created by J.P. Illanes on 08/02/2015.
//  Copyright (c) 2015 J.P. Illanes. All rights reserved.
//

#import "RPViewController.h"

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
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"module://test"]];
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
