//
//  SplashViewController.m
//  Sweepstakes
//
//  Created by macmini3 on 15/12/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "SplashViewController.h"



#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568 )

@interface SplashViewController ()

@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [self gonext];
    NSString* moviePath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mov"];
    NSURL* movieURL = [NSURL fileURLWithPath:moviePath];
    
   playerCtrl =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    playerCtrl.scalingMode = MPMovieScalingModeFill ;
    playerCtrl.controlStyle = MPMovieControlStyleNone;
    playerCtrl.view.frame = self.view.frame;
    if (IS_IPHONE_5) {
         playerCtrl.view.frame = CGRectMake(0, 0, 320, 568);
    }
  
    playerCtrl.repeatMode = MPMovieRepeatModeNone;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(AnimationComplete)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    

  
    [self.view addSubview:playerCtrl.view];
    [playerCtrl play];
}


- (void)AnimationComplete
{
   
    [self performSelector:@selector(gonext) withObject:nil afterDelay:0.4];
  
}
- (void)gonext{

   LoginViewController *gotoview = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    [UIView  transitionWithView:self.navigationController.view duration:1.5  options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^(void) {
                         BOOL oldState = [UIView areAnimationsEnabled];
                         [UIView setAnimationsEnabled:NO];
                         [self.navigationController pushViewController:gotoview animated:YES];
                         [UIView setAnimationsEnabled:oldState];
                     }
                     completion:nil];
    NSMutableArray * viewControllers = [self.navigationController.viewControllers mutableCopy ];
    
    [ viewControllers removeObject:self] ;
    self.navigationController.viewControllers = viewControllers ;
    
 

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
   
 
    [super dealloc];
}
- (void)viewDidUnload {
    
    [super viewDidUnload];
}
@end
