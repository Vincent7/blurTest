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
@property(strong,nonatomic) NSURL *appStoreUrl;
@property(strong,nonatomic) NSString *appName;
@property(strong,nonatomic) NSString *appDescription;
-(id)initWithImage:(UIImage*)iconImage andDetailImages:(NSArray*)arrImages andName:(NSString*)name andDescription:(NSString*)des;
//TODO: add more attributes here like: url?
@end
