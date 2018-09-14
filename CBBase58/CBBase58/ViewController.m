//
//  ViewController.m
//  CBBase58
//
//  Created by caobo56 on 2018/4/19.
//  Copyright © 2018年 caobo56. All rights reserved.
//

#import "ViewController.h"
#import "NS+BTCBase58.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Base58TestCase];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Base58TestCase{
    NSString * tt = @"ttttt";
    NSLog(@"dataFromBase58 = %@\n dataFromBase58Check = %@",[tt dataFromBase58],[tt dataFromBase58Check]);
    
    NSData * ttdata = [tt dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"base58String = %@\n dataFromBase58Check = %@",[ttdata base58String],[tt dataFromBase58Check]);

}


@end
