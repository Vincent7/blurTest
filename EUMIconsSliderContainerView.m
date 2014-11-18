//
//  EUMIconsSliderContainerView.m
//  blurTest
//
//  Created by Vincent on 14/11/14.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "EUMIconsSliderContainerView.h"
#define ORDWIDTH 150
#define GAPWIDTH 50
#define DECREASERAIO .8
typedef NS_ENUM(NSInteger, TestColor)
{
    TestColorCyan = 0,
    TestColorRed = 1,
    TestColorBlue = 2,
    TestColorGreen = 3,
    TestColorYellow = 4,
    TestColorGray = 5,
    TestColorOrange = 6
};
@implementation EUMIconsSliderContainerView
{
    int newSelectedIndex;
    float contentsXOff;
    NSMutableDictionary *iconDistance;
    int lastIconIndex;
}
-(void)setArrIcons:(NSMutableArray *)arrIcons{
    if (arrIcons.count%2==0) {
        EUMBlurIconImageView *iv = [[EUMBlurIconImageView alloc]initWithImage:nil];
        [arrIcons addObject:iv];
    }
    _arrIcons = arrIcons;
    
    iconDistance = [NSMutableDictionary dictionaryWithCapacity:arrIcons.count];
    newSelectedIndex = (int)arrIcons.count/2;
    self.contentSize = CGSizeMake(self.viewSize.width + (arrIcons.count-1)*ORDWIDTH/2, self.viewSize.height);
    [self configIconWithTopIndex:newSelectedIndex];
    [self setContentOffset:CGPointMake(self.contentSize.width/2 - self.viewSize.width/2, 0)];
    self.delegate = self;
    self.decelerationRate = .5;
    [self arrangeIconsView];
    lastIconIndex = -1;
    [self.iconSliderDelegate selectedNewIcon:newSelectedIndex andLastIconIndex:lastIconIndex];
    lastIconIndex = newSelectedIndex;
}
#pragma mark TestMethods
-(UIColor*)getColorWithIndex:(int)index{
    UIColor *c;
    switch (index%7) {
        case TestColorCyan:
            c = [UIColor cyanColor];
            break;
        case TestColorRed:
            c = [UIColor redColor];
            break;
        case TestColorBlue:
            c = [UIColor blueColor];
            break;
        case TestColorGreen:
            c = [UIColor greenColor];
            break;
        case TestColorYellow:
            c = [UIColor yellowColor];
            break;
        case TestColorGray:
            c = [UIColor grayColor];
            break;
        case TestColorOrange:
            c = [UIColor orangeColor];
            break;
        default:
            break;
    }
    return c;
}
-(void)createTestIconsViewWithSum:(int)sum{
    for (int i = 0; i<sum; i++) {
        UIView *iconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ORDWIDTH, ORDWIDTH)];
        iconView.backgroundColor = [self getColorWithIndex:i];
        [_arrIcons addObject:iconView];
    }
}
#pragma mark Init Methods
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _arrIcons = [NSMutableArray array];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _arrIcons = [NSMutableArray array];        
    }
    return self;
}


-(void)setIconFrameWithIndex:(int)index{
    int disIndex = index - newSelectedIndex;
    EUMBlurIconImageView *view = [_arrIcons objectAtIndex:index];
    float dis = disIndex * GAPWIDTH ;
    [iconDistance setObject:@((dis>=0)?dis:-dis) forKey:@(index)];
    float sizeWidth = [self getSizeWidthWithViewCenterDistance:(dis>=0)?dis:-dis];
    view.blurRadius = [self setBlurRadiusWithDis:(dis>=0)?dis:-dis];
    view.frame = CGRectMake(0, 0, sizeWidth, sizeWidth);
    view.center = CGPointMake(dis + self.contentSize.width/2, self.viewSize.height/2);

    view.backgroundColor = [UIColor clearColor];/*[self getColorWithIndex:index];*/
    [self addSubview:view];
}
-(float)getSizeWidthWithViewCenterDistance:(float)dis{
    float a = dis/GAPWIDTH;
    return ORDWIDTH * powf(DECREASERAIO, a) * 1/((1+dis/300));
}
-(void)configIconWithTopIndex:(int)index{
    for (int i = 0; i<_arrIcons.count; i++) {
        [self setIconFrameWithIndex:i];
    }
    
}
-(float)getDistanceToScreenFromViewWithIndex:(int)index{
    EUMBlurIconImageView *v = [_arrIcons objectAtIndex:index];
    CGPoint p = [v.superview convertPoint:v.center fromView:nil];
    if (p.x<self.contentSize.width - self.viewSize.width/2) {
        return -p.x + self.contentSize.width - self.viewSize.width/2;
    }else{
        return p.x - self.contentSize.width + self.viewSize.width/2;
    }
    
}
-(float)getRealDistanceToScreenFromViewWithIndex:(int)index{
    EUMBlurIconImageView *v = [_arrIcons objectAtIndex:index];
    CGPoint p = [v.superview convertPoint:v.center fromView:nil];
    return p.x - self.contentSize.width + self.viewSize.width/2;
}
-(float)setBlurRadiusWithDis:(float)dis{
    int radius = (dis/(self.viewSize.width/2))*10;
    
    return (float)radius/2;
}


- (NSArray *)sortKeysByFloatValue:(NSDictionary *)dictionary {
    
    NSArray *sortedKeys = [dictionary keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int v1 = [obj1 floatValue];
        int v2 = [obj2 floatValue];
        if (v1 < v2)
            return NSOrderedAscending;
        else if (v1 > v2)
            return NSOrderedDescending;
        else
            return NSOrderedSame;
    }];
    return sortedKeys;
}
-(void)arrangeIconsView{
    NSArray* values = [self sortKeysByFloatValue:iconDistance];
    for (int i = (int)values.count-1; i>=0; i--) {
        
        EUMBlurIconImageView *view = [_arrIcons objectAtIndex:[[values objectAtIndex:i] integerValue]];
        [self insertSubview:view atIndex:(int)values.count-1-i];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    for (int i = 0; i<_arrIcons.count; i++) {
        float dis = [self getDistanceToScreenFromViewWithIndex:(int)(_arrIcons.count - i-1)];
        
        float sizeWidth = [self getSizeWidthWithViewCenterDistance:dis];
        EUMBlurIconImageView *view = [_arrIcons objectAtIndex:i];
        
        view.blurRadius = [self setBlurRadiusWithDis:dis];
        view.frame = CGRectMake(0, 0, sizeWidth, sizeWidth);
        view.center = CGPointMake((i - newSelectedIndex) * GAPWIDTH + self.contentSize.width/2, self.viewSize.height/2);
        [iconDistance setObject:@(dis) forKey:@(i)];
        
    }
    [self arrangeIconsView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int minDisIndex = 0;
    NSLog(@"scrollViewDidEndDecelerating");
    for (int i = 0; i<_arrIcons.count; i++) {
        float dis = [self getDistanceToScreenFromViewWithIndex:(int)(_arrIcons.count - i-1)];
        if (dis<[self getDistanceToScreenFromViewWithIndex:(int)(_arrIcons.count - minDisIndex-1)]) {
            minDisIndex = i;
        }
        
    }
    [self sliderMoveIconWithIndex:minDisIndex];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        NSLog(@"scrollViewDidEndDragging");
        int minDisIndex = 0;
        for (int i = 0; i<_arrIcons.count; i++) {
            float dis = [self getDistanceToScreenFromViewWithIndex:(int)(_arrIcons.count - i-1)];
            if (dis<[self getDistanceToScreenFromViewWithIndex:(int)(_arrIcons.count - minDisIndex-1)]) {
                minDisIndex = i;
            }
        }
        [self sliderMoveIconWithIndex:minDisIndex];
    }
}
-(void)sliderMoveIconWithIndex:(int)index{
    [self setContentOffset:CGPointMake(self.contentOffset.x - [self getRealDistanceToScreenFromViewWithIndex:(int)(_arrIcons.count - index-1)], self.contentOffset.y) animated:YES];
    [self.iconSliderDelegate selectedNewIcon:index andLastIconIndex:lastIconIndex];
    lastIconIndex = index;
}
-(void)moveLeft{
    if (lastIconIndex>0) {
        [self sliderMoveIconWithIndex:lastIconIndex-1];
    }
    
}
-(void)moveRight{
    if (lastIconIndex<_arrIcons.count-1) {
        [self sliderMoveIconWithIndex:lastIconIndex+1];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
