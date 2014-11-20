//
//  EUMUkesAppCreater.h
//  blurTest
//
//  Created by Vincent on 14/11/19.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EUMUkesAppCreater : NSObject
@property (strong,nonatomic) NSDictionary *dicAppInfo;
+(EUMUkesAppCreater *)eumUkesAppCreater;
-(void)showUkesAppViewControllerOnViewController:(UIViewController*)vc;
@end
