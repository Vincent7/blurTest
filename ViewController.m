//
//  ViewController.m
//  blurTest
//
//  Created by Vincent on 14/11/14.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "ViewController.h"
#import "EUMAppsForUkersViewController.h"
#import "EUMUkesAppCreater.h"
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

    
    [[EUMUkesAppCreater eumUkesAppCreater]showUkesAppViewControllerOnViewController:self];
}


@end
