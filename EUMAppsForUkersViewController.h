//
//  EUMAppsForUkersViewController.h
//  blurTest
//
//  Created by Vincent on 14/11/17.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUMIconsSliderContainerView.h"
#import "EUMUkeIconInfo.h"
#import "BaseUtils.h"
@interface EUMAppsForUkersViewController : UIViewController<EUMIconSliderDelegate>
-(instancetype)initWithArrIconsInfo:(NSArray*)arrIcon andViewController:(UIViewController*)vc;
@end
