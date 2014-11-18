//
//  EUMUkeIconInfo.m
//  blurTest
//
//  Created by Vincent on 14/11/17.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "EUMUkeIconInfo.h"

@implementation EUMUkeIconInfo
-(id)initWithImage:(UIImage *)iconImage andDetailImages:(NSArray *)arrImages{
    self = [super init];
    if (self) {
        self.iconImage = iconImage;
        self.arrDetailImages = [NSArray arrayWithArray:arrImages];
    }
    return self;
}
@end
