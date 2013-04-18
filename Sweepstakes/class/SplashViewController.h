//
//  SplashViewController.h
//  Sweepstakes
//
//  Created by macmini3 on 15/12/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface SplashViewController : UIViewController<UIWebViewDelegate>{
       
    MPMoviePlayerController *playerCtrl;
}


@end
