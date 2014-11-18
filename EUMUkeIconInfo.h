//
//  EUMUkeIconInfo.h
//  blurTest
//
//  Created by Vincent on 14/11/17.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface EUMUkeIconInfo : NSObject
@property(strong,nonatomic) UIImage *iconImage;
@property(strong,nonatomic) NSArray *arrDetailImages;
-(id)initWithImage:(UIImage*)iconImage andDetailImages:(NSArray*)arrImages;
//TODO: add more attributes here like: url?
@end
