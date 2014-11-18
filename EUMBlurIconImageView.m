//
//  EUMBlurIconImageView.m
//  blurTest
//
//  Created by Vincent on 14/11/14.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "EUMBlurIconImageView.h"
#import "UIImage+ImageEffects.h"
@implementation EUMBlurIconImageView{
    UIImage *originImage;
}
-(void)setBlurRadius:(float)blurRadius{
    if(blurRadius!=_blurRadius){
        _blurRadius = blurRadius;
        self.image =  [originImage applyBlurWithRadius:blurRadius tintColor:[UIColor colorWithWhite:1 alpha:0] saturationDeltaFactor:1 maskImage:nil];
        self.alpha = 1 - .6*(blurRadius/2.5);
    }
    
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
//        self.layer.cornerRadius = 18;
        self.clipsToBounds = YES;
        originImage = self.image.copy;
        self.image =  [self.image applyBlurWithRadius:_blurRadius tintColor:[UIColor colorWithWhite:1 alpha:0] saturationDeltaFactor:1 maskImage:nil];
    }
    return self;
}
-(instancetype)initWithImage:(UIImage *)image{
    self = [super initWithImage:image];
    if(self){
//        self.layer.cornerRadius = 18;
        self.clipsToBounds = YES;
        originImage = self.image.copy;
        self.blurRadius = 1;
//        self.frame = CGRectMake(0, 0, 110, 110);
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
