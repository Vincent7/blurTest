//
//  ViewController.m
//  blurTest
//
//  Created by Vincent on 14/11/14.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "ViewController.h"
#import "EUMAppsForUkersViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [vev.layer setCornerRadius:18];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)presentVC:(id)sender {
    
    EUMUkeIconInfo *icon1 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"iuke"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    EUMUkeIconInfo *icon2 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"ms"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    EUMUkeIconInfo *icon3 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uc"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    EUMUkeIconInfo *icon4 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uh"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    EUMUkeIconInfo *icon5 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uk"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    EUMUkeIconInfo *icon6 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uke101"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    EUMUkeIconInfo *icon7 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"ut"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]];
    
    [self presentViewController:[[EUMAppsForUkersViewController alloc]initWithArrIconsInfo:@[icon1,icon2,icon3,icon4,icon5,icon6,icon7]] animated:YES completion:nil];
}


@end
