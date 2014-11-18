//
//  EUMAppsForUkersViewController.m
//  blurTest
//
//  Created by Vincent on 14/11/17.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "EUMAppsForUkersViewController.h"
#import "EUMIconsSliderContainerView.h"
#import "EUMBlurIconImageView.h"
#define ANIMTIME .2
#define CHANGEIMAGEGAPTIME 4.0
@interface EUMAppsForUkersViewController ()

@end

@implementation EUMAppsForUkersViewController{
    
    IBOutlet EUMIconsSliderContainerView *sliderVIew;
    NSArray *arrIconViews;
    NSArray *arrInfoViews;
    IBOutlet UIImageView *mainDetailImage;
    int detailImageIndex;
    int nowIconIndex;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sliderVIew.iconSliderDelegate = self;
    sliderVIew.viewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,sliderVIew.frame.size.height);
    [sliderVIew setArrIcons:[NSMutableArray arrayWithArray:arrIconViews]];
    
    mainDetailImage.layer.masksToBounds = NO;
    mainDetailImage.layer.cornerRadius = 8; // if you like rounded corners
    mainDetailImage.layer.shadowOffset = CGSizeMake(0, 15);
    mainDetailImage.layer.shadowRadius = 12;
    mainDetailImage.layer.shadowOpacity = 1;
    mainDetailImage.layer.shadowColor = [UIColor colorWithRed:24/255 green:66/255 blue:83/255 alpha:.5].CGColor;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(instancetype)initWithArrIconsInfo:(NSArray*)arrIcons{
    self = [super init];
    if (self) {
        NSMutableArray *arrTempIcon = [NSMutableArray array];
        NSMutableArray *arrTempInfo = [NSMutableArray array];
        for (EUMUkeIconInfo *info in arrIcons) {
            EUMBlurIconImageView *iv = [[EUMBlurIconImageView alloc]initWithImage:info.iconImage];
            [arrTempIcon addObject:iv];
            [arrTempInfo addObject:info.arrDetailImages];
        }
        //TODO: replace arricons with EUMUkeIconInfos
        arrIconViews = [NSArray arrayWithArray:arrTempIcon];
        arrInfoViews = [NSArray arrayWithArray:arrTempInfo];
    }
    return self;
}
-(void)changeDetailImage{
    NSArray *arrIconsDetail = [NSArray arrayWithArray:(NSArray*)[arrInfoViews objectAtIndex:nowIconIndex]];

    detailImageIndex++;
    if (detailImageIndex>=(arrIconsDetail.count)) {
        detailImageIndex = 0;
    }

    [UIView transitionWithView:self.view
                      duration:ANIMTIME*4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [mainDetailImage setImage:(UIImage*)[arrIconsDetail objectAtIndex:detailImageIndex]];
                    } completion:NULL];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)scrollLeft:(id)sender {
    [sliderVIew moveLeft];
}
- (IBAction)scrollRight:(id)sender {
    [sliderVIew moveRight];
}
-(void)selectedNewIcon:(int)iconIndex andLastIconIndex:(int)lastIconIndex{
    if (iconIndex!=lastIconIndex || lastIconIndex == -1) {
        [timer invalidate];
        timer = nil;
        nowIconIndex = iconIndex;
        detailImageIndex = 0;
        NSArray *arrIconDetailImages = [NSArray arrayWithArray:(NSArray*)[arrInfoViews objectAtIndex:nowIconIndex]];
        UIView *snapLastView = [mainDetailImage snapshotViewAfterScreenUpdates:NO];
        snapLastView.frame = [self.view convertRect:mainDetailImage.bounds fromView:mainDetailImage];
        [self.view addSubview:snapLastView];
        mainDetailImage.alpha = 0;
        
        UIImageView *nextSnap = [[UIImageView alloc]initWithImage:(UIImage*)[arrIconDetailImages firstObject]];
        nextSnap.alpha = 0;
        nextSnap.frame = CGRectMake((nowIconIndex>lastIconIndex)?snapLastView.frame.origin.x + snapLastView.frame.size.width/2:snapLastView.frame.origin.x - snapLastView.frame.size.width/2, snapLastView.frame.origin.y, snapLastView.frame.size.width, snapLastView.frame.size.height);
        [self.view addSubview:nextSnap];
        [UIView animateWithDuration:ANIMTIME animations:^{
            nextSnap.frame = CGRectMake(snapLastView.frame.origin.x, snapLastView.frame.origin.y, snapLastView.frame.size.width, snapLastView.frame.size.height);
            nextSnap.alpha = 1;
        } completion:^(BOOL finished) {
            [nextSnap setAlpha:0];
            [nextSnap removeFromSuperview];
        }];
        
        [UIView animateWithDuration:ANIMTIME animations:^{
            snapLastView.frame = CGRectMake((nowIconIndex>lastIconIndex)?snapLastView.frame.origin.x - snapLastView.frame.size.width/2:snapLastView.frame.origin.x + snapLastView.frame.size.width/2, snapLastView.frame.origin.y, snapLastView.frame.size.width, snapLastView.frame.size.height);
            snapLastView.alpha = 0;
        } completion:^(BOOL finished) {
            [mainDetailImage setAlpha:1];
            [mainDetailImage setImage:(UIImage*)[arrIconDetailImages firstObject]];
            [snapLastView removeFromSuperview];
            timer =  [NSTimer scheduledTimerWithTimeInterval:CHANGEIMAGEGAPTIME target:self selector:@selector(changeDetailImage) userInfo:nil repeats:YES];
        }];
    }
    
}

@end
