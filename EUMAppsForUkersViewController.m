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
#define ANIMTIME .6
#define FADEANIMTIME .8
#define CHANGEIMAGEGAPTIME 4.0
#define MAINIMAGEXOFF 1/8
#define CONSTRAINTRATIO 327.0/568.0
#define NOWSCREENWITDH (mIsIOS8orLater)?[UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height
@interface EUMAppsForUkersViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *gapWidthConstraint;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@end

@implementation EUMAppsForUkersViewController{
    
    IBOutlet EUMIconsSliderContainerView *sliderVIew;
    
    NSArray *arrIconViews;
    NSArray *arrInfoViews;
    NSArray *arrNameString;
    NSArray *arrDesString;
    
    IBOutlet UIImageView *mainDetailImage;
    int detailImageIndex;
    int nowIconIndex;
    NSTimer *timer;
    
    IBOutlet UIButton *downloadButton;
    IBOutlet UILabel *lblAppName;
    IBOutlet UILabel *lblAppDescription;

    UIViewController *backgroundViewController;
    IBOutlet UIButton *moveLeftButton;
    IBOutlet UIButton *moveRightButton;
    IBOutlet NSLayoutConstraint *constraintYOffCenter;
    IBOutlet UIView *containerView;
    
}
-(void)viewDidLayoutSubviews{
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    sliderVIew.iconSliderDelegate = self;
    
    if (UIInterfaceOrientationIsPortrait(super.interfaceOrientation) &&!mIsPad) {
        sliderVIew.viewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,sliderVIew.frame.size.height);
        
    }else{
        if (mIsPad) {
            sliderVIew.viewSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,sliderVIew.frame.size.height);
        }else{
            float ratio = CONSTRAINTRATIO;
            
            float width;
            if (mIsIOS8orLater) {
                width=[UIScreen mainScreen].bounds.size.width;
            }else{
                width=[UIScreen mainScreen].bounds.size.height;
            }
            NSLog(@"[UIScreen mainScreen].bounds.size.width:%f",width);
            sliderVIew.viewSize = CGSizeMake(width*ratio,sliderVIew.frame.size.height);
        }
    }
    if (mIsPad) {
        [UIView animateWithDuration:ANIMTIME/3 animations:^{
            constraintYOffCenter.constant = 10;
            [containerView setNeedsLayout];
            [containerView layoutIfNeeded];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMTIME/6 animations:^{
                constraintYOffCenter.constant = -5;
                [containerView setNeedsLayout];
                [containerView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:ANIMTIME/6 animations:^{
                    constraintYOffCenter.constant = 0;
                    [containerView setNeedsLayout];
                    [containerView layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [sliderVIew setArrIcons:[NSMutableArray arrayWithArray:arrIconViews]];
                    [self ControlsAnimation];
                }];
            }];
        }];
    }else{
        [sliderVIew setArrIcons:[NSMutableArray arrayWithArray:arrIconViews]];
        [self ControlsAnimation];
    }
    NSLog(@"SW:%f",sliderVIew.contentSize.width);
    NSLog(@"FW:%f",sliderVIew.frame.size.width);
//    [sliderVIew sliderMoveIconWithIndex:(int)arrIconViews.count/2];
}
#define FRISTGROUPSHOWUPTIME .6
#define SECONDGROUPSHOWUPTIME .8
- (void)ControlsAnimation{
    [UIView transitionWithView:sliderVIew
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [sliderVIew setAlpha:1];
                    } completion:NULL];
    [UIView transitionWithView:moveLeftButton
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [moveLeftButton setAlpha:1];
                    } completion:NULL];
    [UIView transitionWithView:moveRightButton
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [moveRightButton setAlpha:1];
                    } completion:NULL];
    
    [UIView transitionWithView:lblAppName
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [lblAppName setAlpha:1];
                    } completion:NULL];
    [UIView transitionWithView:lblAppDescription
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [lblAppDescription setAlpha:1];
                    } completion:NULL];
    
    [UIView transitionWithView:downloadButton
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [downloadButton setAlpha:.8];
                    } completion:NULL];
    
    [UIView transitionWithView:mainDetailImage
                      duration:FRISTGROUPSHOWUPTIME
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [mainDetailImage setAlpha:1];
                    } completion:NULL];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *backView = [backgroundViewController.view snapshotViewAfterScreenUpdates:NO];
    [_backgroundView insertSubview:backView atIndex:0];
    mainDetailImage.layer.masksToBounds = NO;
    mainDetailImage.layer.cornerRadius = 8; // if you like rounded corners
    mainDetailImage.layer.shadowOffset = CGSizeMake(0, 15);
    mainDetailImage.layer.shadowRadius = 12;
    mainDetailImage.layer.shadowOpacity = 1;
    mainDetailImage.layer.shadowColor = [UIColor colorWithRed:24.0/255.0 green:66.0/255.0 blue:83.0/255 alpha:.5].CGColor;
    
    downloadButton.layer.borderColor = [UIColor colorWithRed:9.0/255.0 green:114.0/255.0 blue:180.0/255.0 alpha:1].CGColor;
    downloadButton.layer.cornerRadius = 4;
    downloadButton.layer.borderWidth = 1;
    if (mIsPad) {
        constraintYOffCenter.constant = - self.view.frame.size.height/2 - containerView.frame.size.height/2;
        [containerView setNeedsLayout];
        [containerView layoutIfNeeded];
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)changeConstraint{
//    if (mIsPhone3_4_4S || mIsPhone5) {
//        _gapWidthConstraint.constant = CONSTRAINTRATIO * [UIScreen mainScreen].bounds.size.height;
//        [mainDetailImage setNeedsLayout];
//        [mainDetailImage layoutIfNeeded];
//    }else{
//        
//    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressedCloseButton:(id)sender {
    if (mIsPad) {
        [UIView animateWithDuration:ANIMTIME/3 animations:^{
            constraintYOffCenter.constant = - self.view.frame.size.height/2 - containerView.frame.size.height/2;
            [containerView setNeedsLayout];
            [containerView layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
        
    }else{
       [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(instancetype)initWithArrIconsInfo:(NSArray*)arrIcons andViewController:(UIViewController*)vc{
    if (mIsPad) {
        self = [super initWithNibName:@"EUMAppsForUkersViewControlleriPad" bundle:nil];
    }else{
        if (UIInterfaceOrientationIsPortrait(super.interfaceOrientation)) {
            
            self = [super initWithNibName:@"EUMAppsForUkersViewController" bundle:nil];
        }else{
            self = [super initWithNibName:@"EUMAppsForUkersViewControllerHoriazion" bundle:nil];
        }
    }
    
    
    if (self) {
        NSMutableArray *arrTempIcon = [NSMutableArray array];
        NSMutableArray *arrTempInfo = [NSMutableArray array];
        NSMutableArray *arrTempName = [NSMutableArray array];
        NSMutableArray *arrTempDes = [NSMutableArray array];
        for (EUMUkeIconInfo *info in arrIcons) {
            EUMBlurIconImageView *iv = [[EUMBlurIconImageView alloc]initWithImage:info.iconImage];
            [arrTempIcon addObject:iv];
            [arrTempInfo addObject:info.arrDetailImages];
            [arrTempName addObject:info.appName];
            [arrTempDes addObject:info.appDescription];
        }
        //TODO: replace arricons with EUMUkeIconInfos
        arrIconViews = [NSArray arrayWithArray:arrTempIcon];
        arrInfoViews = [NSArray arrayWithArray:arrTempInfo];
        arrNameString = [NSArray arrayWithArray:arrTempName];
        arrDesString = [NSArray arrayWithArray:arrTempDes];
        backgroundViewController = vc;
    }
    return self;
}

-(void)changeDetailImage{
    
    NSArray *arrIconsDetail = [NSArray arrayWithArray:(NSArray*)[arrInfoViews objectAtIndex:nowIconIndex]];
   
    detailImageIndex++;
    if (detailImageIndex>=(arrIconsDetail.count)) {
        detailImageIndex = 0;
    }
    
    [UIView transitionWithView:mainDetailImage
                      duration:FADEANIMTIME
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
    NSLog(@"SelectNewIcon");
    if (iconIndex!=lastIconIndex || lastIconIndex == -1) {
        [timer invalidate];
        timer = nil;
        nowIconIndex = iconIndex;
        detailImageIndex = 0;
        NSArray *arrIconDetailImages = [NSArray arrayWithArray:(NSArray*)[arrInfoViews objectAtIndex:nowIconIndex]];
        if (lastIconIndex!=-1) {
            UIView *snapLastView = [mainDetailImage snapshotViewAfterScreenUpdates:NO];
            snapLastView.frame = [self.view convertRect:mainDetailImage.bounds fromView:mainDetailImage];
            [self.view addSubview:snapLastView];
            mainDetailImage.alpha = 0;
            
            UIImageView *nextSnap = [[UIImageView alloc]initWithImage:(UIImage*)[arrIconDetailImages firstObject]];
            nextSnap.alpha = 0;
            nextSnap.frame = CGRectMake((nowIconIndex>lastIconIndex)?snapLastView.frame.origin.x + snapLastView.frame.size.width*MAINIMAGEXOFF:snapLastView.frame.origin.x - snapLastView.frame.size.width*MAINIMAGEXOFF, snapLastView.frame.origin.y, snapLastView.frame.size.width, snapLastView.frame.size.height);
            [self.view addSubview:nextSnap];
            
            [UIView animateWithDuration:ANIMTIME animations:^{
                nextSnap.frame = CGRectMake(snapLastView.frame.origin.x, snapLastView.frame.origin.y, snapLastView.frame.size.width, snapLastView.frame.size.height);
                nextSnap.alpha = 1;
            } completion:^(BOOL finished) {
                [nextSnap setAlpha:0];
                [nextSnap removeFromSuperview];
            }];
            
            [UIView animateWithDuration:ANIMTIME animations:^{
                snapLastView.frame = CGRectMake((nowIconIndex>lastIconIndex)?snapLastView.frame.origin.x - snapLastView.frame.size.width*MAINIMAGEXOFF:snapLastView.frame.origin.x + snapLastView.frame.size.width*MAINIMAGEXOFF, snapLastView.frame.origin.y, snapLastView.frame.size.width, snapLastView.frame.size.height);
                snapLastView.alpha = 0;
            } completion:^(BOOL finished) {
                [mainDetailImage setAlpha:1];
                [mainDetailImage setImage:(UIImage*)[arrIconDetailImages firstObject]];
                [snapLastView removeFromSuperview];
                if (timer == nil) {
                    timer =  [NSTimer scheduledTimerWithTimeInterval:CHANGEIMAGEGAPTIME target:self selector:@selector(changeDetailImage) userInfo:nil repeats:YES];
                }
            }];
            NSString *appDesStr = [arrDesString objectAtIndex:nowIconIndex];
            NSString *appNameStr = [arrNameString objectAtIndex:nowIconIndex];
            [UIView transitionWithView:lblAppDescription
                              duration:ANIMTIME
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [lblAppDescription setText:appDesStr];
                                
                            } completion:NULL];
            [UIView transitionWithView:lblAppName
                              duration:ANIMTIME
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [lblAppName setText:appNameStr];
                                
                            } completion:NULL];
        }else{
            [mainDetailImage setAlpha:1];
            [mainDetailImage setImage:(UIImage*)[arrIconDetailImages firstObject]];
            if (timer == nil) {
                timer =  [NSTimer scheduledTimerWithTimeInterval:CHANGEIMAGEGAPTIME target:self selector:@selector(changeDetailImage) userInfo:nil repeats:YES];
            }
            NSString *appDesStr = [arrDesString objectAtIndex:nowIconIndex];
            NSString *appNameStr = [arrNameString objectAtIndex:nowIconIndex];
            [lblAppDescription setText:appDesStr];
            [lblAppName setText:appNameStr];
        }
        
        
    }
    
}
- (IBAction)ShowNextImage:(id)sender {
    [self changeDetailImage];
}
- (IBAction)pressedDownLoadButton:(id)sender {
    
}

@end
