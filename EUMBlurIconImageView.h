//
//  EUMBlurIconImageView.h
//  blurTest
//
//  Created by Vincent on 14/11/14.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EUMBlurIconImageView : UIImageView
@property (assign,nonatomic) float blurRadius;
-(instancetype)initWithImage:(UIImage *)image;
@end
