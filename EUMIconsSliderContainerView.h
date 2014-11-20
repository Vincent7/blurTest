//
//  EUMIconsSliderContainerView.h
//  blurTest
//
//  Created by Vincent on 14/11/14.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//
@protocol EUMIconSliderDelegate

@required
-(void)selectedNewIcon:(int)iconIndex andLastIconIndex:(int)lastIconIndex;

@end
#import <UIKit/UIKit.h>
#import "EUMBlurIconImageView.h"
@interface EUMIconsSliderContainerView : UIScrollView<UIScrollViewDelegate>
@property (strong,nonatomic) NSMutableArray *arrIcons;
@property (weak,nonatomic) id<EUMIconSliderDelegate> iconSliderDelegate;
@property (assign,nonatomic) CGSize viewSize;

-(void)moveLeft;
-(void)moveRight;
-(void)sliderMoveIconWithIndex:(int)index;
//TODO:create a method for getting screenWidth
@end
