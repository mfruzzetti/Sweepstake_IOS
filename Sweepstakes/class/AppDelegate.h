//
//  AppDelegate.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "Flurry.h"
#import "FlurryAds.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "WinnerlistViewController.h"
#import "LoginViewController.h"
#import "SplashViewController.h"
#import <sqlite3.h>
#import "DDMenuController.h"
#import "LLDataControll.h"
#import "MenuViewController.h"
#import "Apsalar.h"
#import "GAI.h"
#import "SponsorPaySDK.h"

#define CURRENT_LIST_ITEM_SWEEP_STAKES_LIST     0
#define CURRENT_LIST_ITEM_WINNERS_LIST          1
#define CURRENT_LIST_ITEM_MY_PROFILE            2
#define CURRENT_LIST_ITEM_HOW_IT_WORKS          3
#define CURRENT_LIST_ITEM_SWEEP_STAKES_DETAIL   4

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

sqlite3 *database;
@class GooglePlusShare;
@class LoginViewController;
@class SplashViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    LLDataControll *dc;
    int nCurrentListItem;
   
    UINavigationController* tempNav;
    NSMutableDictionary *cardCounter;
}
    @property(nonatomic,retain) NSMutableDictionary *cardCounter;


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) LoginViewController *viewController;
@property (strong,nonatomic) SplashViewController *splashview;
@property(nonatomic,retain) NSString *databaseName;
@property(nonatomic,retain) NSString *databasePath;
@property(nonatomic,retain) NSString * tokenstring;
@property (retain, nonatomic) GooglePlusShare *share;
@property (nonatomic,assign) bool applied;
@property (nonatomic,assign) int nCurrentListItem;
@property (strong, nonatomic) UINavigationController* tempNav;

//@property(retain, nonatomic) NSString *pushid;


-(BOOL)isHostAvailable;
-(BOOL)isNetAvalable;
@end
