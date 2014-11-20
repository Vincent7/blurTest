//
//  EUMUkesAppCreater.m
//  blurTest
//
//  Created by Vincent on 14/11/19.
//  Copyright (c) 2014年 EUMLab. All rights reserved.
//

#import "EUMUkesAppCreater.h"
#import "EUMUkeIconInfo.h"
#import "EUMAppsForUkersViewController.h"

#define AppList  [[NSBundle mainBundle] pathForResource:@"AppList" ofType:@"plist"]
static EUMUkesAppCreater *_EUMUkesAppCreater = nil;
@implementation EUMUkesAppCreater{
    
}
+(EUMUkesAppCreater *)eumUkesAppCreater{
    if (_EUMUkesAppCreater==nil) {
        _EUMUkesAppCreater = [[EUMUkesAppCreater alloc]init];
        
    }
    return _EUMUkesAppCreater;
}

-(NSArray*)createTestData{
    EUMUkeIconInfo *icon1 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"iuke"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]] andName:@"iUke" andDescription:@"iUke Description\niUke Description"];
    EUMUkeIconInfo *icon2 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"ms"] andDetailImages:@[[UIImage imageNamed:@"feature2"],[UIImage imageNamed:@"feature1"]] andName:@"Ms" andDescription:@"Ms Description\nMs Description"];
    EUMUkeIconInfo *icon3 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uc"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]andName:@"Uc" andDescription:@"Uc Description\nUc Description"];
    EUMUkeIconInfo *icon4 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uh"] andDetailImages:@[[UIImage imageNamed:@"feature2"],[UIImage imageNamed:@"feature1"]]andName:@"Uh" andDescription:@"Uh Description\nUh Description"];
    EUMUkeIconInfo *icon5 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uk"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]andName:@"Uk" andDescription:@"Uk Description\nUk Description"];
    EUMUkeIconInfo *icon6 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"uke101"] andDetailImages:@[[UIImage imageNamed:@"feature2"],[UIImage imageNamed:@"feature1"]] andName:@"Uke101" andDescription:@"Uke101 Description\nUke101 Description"];
    EUMUkeIconInfo *icon7 = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:@"ut"] andDetailImages:@[[UIImage imageNamed:@"feature1"],[UIImage imageNamed:@"feature2"]]andName:@"Ut" andDescription:@"Ut Description\nUt Description"];
    return @[icon1,icon2,icon3,icon4,icon5,icon6,icon7];
}
-(NSArray*)getAppInfo{
    NSArray *arrAppInfo = [NSArray arrayWithArray:[(NSDictionary*)[NSDictionary dictionaryWithDictionary:[BaseUtils loadDictPlistInPath:AppList]] objectForKey:@"Apps"]];
    return arrAppInfo;
}
-(NSArray*)createIconInfoObjects:(NSArray*)arrInfo{
    NSMutableArray *arrRet = [NSMutableArray arrayWithCapacity:arrInfo.count];
    for (int i = 0; i<arrInfo.count; i++) {
        NSDictionary *dicInfo = [arrInfo objectAtIndex:i];
        NSString *iconImageName = [dicInfo objectForKey:@"iconImage"];
        NSMutableArray *arrDetailImages = [NSMutableArray array];
        for (int j = 0; j<((NSArray *)[dicInfo objectForKey:@"arrDetailImages"]).count; j++) {
            [arrDetailImages addObject:[UIImage imageNamed:[[dicInfo objectForKey:@"arrDetailImages"] objectAtIndex:j]]];
        }
        
        NSString *appName = [dicInfo objectForKey:@"appName"];
        NSString *appDetail = [dicInfo objectForKey:@"appDes"];
        EUMUkeIconInfo *info = [[EUMUkeIconInfo alloc]initWithImage:[UIImage imageNamed:iconImageName]
                                                    andDetailImages:arrDetailImages
                                                            andName:appName
                                                    andDescription:appDetail];
        [arrRet addObject:info];
    }
    return arrRet;
}
-(void)showUkesAppViewControllerOnViewController:(UIViewController *)vc{
    [vc presentViewController:[[EUMAppsForUkersViewController alloc]initWithArrIconsInfo:[self createIconInfoObjects:[self getAppInfo]] andViewController:vc] animated:(mIsPad)?NO:YES completion:nil]; 
}
@end
