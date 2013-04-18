//
//  AppDelegate.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 03/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "TapjoyConnect.h"
#import "vunglepub.h"
@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize splashview = _splashview;
@synthesize databaseName,databasePath;
@synthesize share = share_;
@synthesize tokenstring,applied;
@synthesize menuController = _menuController;
@synthesize nCurrentListItem;
@synthesize tempNav;
@synthesize cardCounter;
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

-(void)vungleStart
{
    VGUserData*  data  = [VGUserData defaultUserData];
    //NSString*    appID = @"51596f62c03ee44e1b00004b";
    NSString*    appID = @"515d993e1cf9155c31000006";       //As per discussions with Michael 4th April
    //NSString*    appID = @"vungleTest";
    
    // set up config data
    //data.age             = 36;
    //data.gender          = VGGenderFemale;
    data.adOrientation   = VGAdOrientationPortrait;
  //  data.locationEnabled = TRUE;
    
    // start vungle publisher library
    [VGVunglePub startWithPubAppID:appID userData:data];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
 

    [self vungleStart];
    
    // Tapjoy 
    [TapjoyConnect requestTapjoyConnect:@"89f9325f-f56d-44d4-954a-09fcd4cf5e16" secretKey:@"7wOYg93VuqQjg3OeFCWt"];
    
    
    
    dc = [[LLDataControll alloc]init];
    self.databaseName = @"sweepstake_db.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    [self createAndCheckDatabase];
    
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK)
	{
		sqlite3_close(database);
		NSLog(@"Failed to open db.");
	}
	else{
		NSLog(@"Open DB");
    }
    
   // NSLog(@"Fluryy->%@",[Flurry getFlurryAgentVersion]);
    //[FlurryAds initialize:self.window.rootViewController];
   // [Flurry startSession:@"NYXBTMDNMJNM8YQRXDY4"];
    [Flurry startSession:@"QMMQM6TN6S9DJP8G9963"];
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // Optional: set debug to YES for extra debugging information.
    [GAI sharedInstance].debug = YES;
    // Create tracker instance.
    //Gogle Analytics
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-38651561-1"];
    
    [tracker setCampaignUrl:@"utm_campaign=my_campaign&utm_source=google&utm_medium=cpc&utm_term=my_keyword&utm_content=ad_variation1"];
    
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
   // NSLog(@"--->%@",[[[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"aps"] objectForKey:@"alert"]);
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
   
    
//    NSString* versionNum = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    NSLog(@"--->%@",versionNum);
//    if (![versionNum isEqualToString:@"1.1"]) {
//       NSLog(@"--->%d", [[[NSUserDefaults standardUserDefaults] stringForKey:@"count"]intValue]) ;
//        int count = [[[NSUserDefaults standardUserDefaults] stringForKey:@"count"]intValue]+1;
//        
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",count] forKey:@"count"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
    if (launchOptions != nil)
	{
		NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
		if (userInfo != nil)
		{
            /*
            FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
            [db open];
            FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
            while ([results next]) 
            {
                pushid = [[NSString alloc]initWithFormat:@"%@",[results stringForColumn:@"userid"]] ;
            }
            [results close];
            [db close];
               */    
            self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
            // Override point for customization after application launch.
            self.viewController = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
            UINavigationController *navigation =[[UINavigationController alloc]initWithRootViewController:self.splashview];
            DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navigation];
            _menuController = rootController;
            MenuViewController *leftController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            _menuController.leftViewController = leftController;
            
            navigation.navigationBar.hidden=YES;
            self.window.rootViewController = rootController;
            
            self.window.backgroundColor = [UIColor clearColor];
            [self.window makeKeyAndVisible];
            
            if ([dc getData])
            {
            WinnerlistViewController *gotowinner = [[WinnerlistViewController alloc]initWithNibName:@"WinnerlistViewController" bundle:nil];
            gotowinner.userid = [[dc getData]objectAtIndex:0];
            [navigation pushViewController:gotowinner animated:YES];
            }
            
			//NSLog(@"Launched from push notification: %@", userInfo);
            
          //  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"launchoption" message:[NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"]objectForKey:@"sub"]] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
         //   [alert show];
         //   [alert release];
           
        }
	}
    else {
        
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.splashview = [[[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil] autorelease];
    UINavigationController *navigation =[[UINavigationController alloc]initWithRootViewController:self.splashview];
        DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navigation];
        _menuController = rootController;
        MenuViewController *leftController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        _menuController.leftViewController = leftController;

     navigation.navigationBar.hidden=YES;
    self.window.rootViewController = rootController;
        
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
   
    }
   
   
   
    return YES;
}



- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken { 
    
  
    tokenstring =[NSString stringWithFormat:@"%@",deviceToken];

    tokenstring = [tokenstring stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	tokenstring = [[NSString alloc]initWithFormat:@"%@",[tokenstring stringByReplacingOccurrencesOfString:@" " withString:@""]];
  

}



- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err { 
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"%@",str);    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
     [dc =[LLDataControll alloc]init];
    for (id key in userInfo) {
      //  NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
       
        // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"remotenotification" message:[NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"]objectForKey:@"sub"]] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        /*
        FMDatabase *db=[FMDatabase databaseWithPath:[Utility getDatabasePath]];
        [db open];
        FMResultSet *results=[db executeQuery:@"SELECT * FROM login_master where rowid=1"];
        while ([results next]) 
        {
            pushid = [[NSString alloc]initWithFormat:@"%@",[results stringForColumn:@"userid"]] ;
           // UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"remotenotification" message:[NSString stringWithFormat:@"idddd->%@",[results stringForColumn:@"userid"]] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          //  [alert show];
          //  [alert release];
        }
        [results close];
        [db close];
        */
        UIApplicationState state = [application applicationState];
        if (state == UIApplicationStateActive)
        {
             UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Push Notification" message:[NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"VIEW" otherButtonTitles:@"CANCEL", nil];
            [alert show];
            [alert release];
           
        }else if (state == UIApplicationStateInactive) {
           
            self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
            // Override point for customization after application launch.
            self.viewController = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
            UINavigationController *navigation =[[UINavigationController alloc]initWithRootViewController:self.splashview];
            DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:navigation];
            _menuController = rootController;
            MenuViewController *leftController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
            _menuController.leftViewController = leftController;
            
            navigation.navigationBar.hidden=YES;
            self.window.rootViewController = rootController;
            
            self.window.backgroundColor = [UIColor clearColor];
            [self.window makeKeyAndVisible];

            if ([dc getData])
            {
                WinnerlistViewController *gotowinner = [[WinnerlistViewController alloc]initWithNibName:@"WinnerlistViewController" bundle:nil];
                gotowinner.userid = [[dc getData]objectAtIndex:0];
                [navigation pushViewController:gotowinner animated:YES];
            }
            
        }

        
    }
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  //  NSLog(@"Alert message: %@",[[userInfo valueForKey:@"aps"] valueForKey:@"alert"]);

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0)
	{
        self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
        // Override point for customization after application launch.
        self.viewController = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
        UINavigationController *navigation =[[UINavigationController alloc]initWithRootViewController:self.viewController];
        navigation.navigationBar.hidden=YES;
        self.window.rootViewController = navigation;
        [self.window makeKeyAndVisible];
        if ([dc getData])
        {
            WinnerlistViewController *gotowinner = [[WinnerlistViewController alloc]initWithNibName:@"WinnerlistViewController" bundle:nil];
            gotowinner.userid = [[dc getData]objectAtIndex:0];
            [navigation pushViewController:gotowinner animated:YES];
        }

        
	}
    
}
- (NSString *)dataFilePath
{
	BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success)
    {
        return databasePath;
        
    }else {
        return NO;
    }
}

-(void) createAndCheckDatabase
{
    BOOL success; 
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success) return; 
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // Handle Google+ share dialog URL.
    if ([share_ handleURL:url
        sourceApplication:sourceApplication
               annotation:annotation]) {
        return YES;
    }
   //Apsalar Analytics
    [Apsalar startSession:@"bventures" withKey:@"YOynplNg" andURL:url];
    return YES;

    // Handle Google+ sign-in button URL.
    return NO;
}


-(BOOL)isHostAvailable
{
	
    Reachability *hostReachable = [Reachability reachabilityWithHostName: @"www.google.com"];
    BOOL isHostAvailable;
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            isHostAvailable = NO;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            isHostAvailable = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            isHostAvailable = YES;
            
            break;
        }
    }
    return isHostAvailable;
    
}

-(BOOL)isNetAvalable
{
    Reachability *internetReachable = [Reachability reachabilityForInternetConnection];
    BOOL isNetAvalable;
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            isNetAvalable = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            isNetAvalable = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            isNetAvalable = YES;
            break;
        }
    }
    return isNetAvalable;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    //Apsalar Analytics
    [Apsalar startSession:@"bventures" withKey:@"YOynplNg"];
//    [SponsorPaySDK startForAppId:@"10780"
//                          userId:nil
//                   securityToken:@"c2732013599a043f3c20f91aaf6cc614"];
    
    NSString *credentialsToken =
    [SponsorPaySDK startForAppId:@"10780"
                          userId:nil
                   securityToken:@"c2732013599a043f3c20f91aaf6cc614"];
    
    
    @try {
        //A88497 is action_id
        
        [SponsorPaySDK reportActionCompleted:@"A88497"
                              forCredentials:credentialsToken];
      
    } @catch (NSException *exception) {
       
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [VGVunglePub stop];
}


@end
