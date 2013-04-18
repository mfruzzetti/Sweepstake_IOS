//
//  GalaryViewController.m
//  Sweepstakes
//
//  Created by Peerbits Solution on 22/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import "GalaryViewController.h"

@interface GalaryViewController ()

@end

@implementation GalaryViewController
@synthesize scrollview,imgarr;
@synthesize mainimageview;

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
    
    UIImageView *imgback = [[UIImageView alloc] init];
    imgback.layer.masksToBounds = YES;
    imgback.layer.borderWidth = 2;
    imgback.layer.cornerRadius = 5;
    imgback.layer.borderColor = [[UIColor colorWithRed:175.0/255.0 green:170.0/255.0 blue:163.0/255.0 alpha:1.0]CGColor]; 
    imgback.frame = CGRectMake(7,45, 305, 280);
    [self.view addSubview:imgback];
    bigimage = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0, 0,303,278)];
    bigimage.delegate = self;
    if ([imgarr count]>0 ) {
    bigimage.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGPATH,[imgarr objectAtIndex:0]]];
    }
    bigimage.backgroundColor= [UIColor clearColor];
    mainimageview.layer.masksToBounds = YES;
    mainimageview.layer.cornerRadius = 5;
    mainimageview.layer.borderWidth = 6;
    mainimageview.layer.borderColor = [[UIColor whiteColor]CGColor];
    [mainimageview addSubview:bigimage];
    
    if (!bigimage.image) 
    {
        [bigimage startLoading];
        bigimage.actv.frame = CGRectMake(140,110 ,30 ,30 );
    }

    int scrollWidth = 180;
	scrollview.contentSize = CGSizeMake(scrollWidth,110);	 
	int xOffset = 4;
    
    for(int i = 0; i < [imgarr count]; ++i) 
    {
        UIImageView *imgback = [[UIImageView alloc] init];
		imgback.layer.masksToBounds = YES;
        imgback.layer.borderWidth = 2;
        imgback.layer.cornerRadius = 7;
        imgback.layer.borderColor = [[UIColor colorWithRed:175.0/255.0 green:170.0/255.0 blue:163.0/255.0 alpha:1.0]CGColor]; 
		imgback.frame = CGRectMake(4+xOffset,0, 147, 112);
        
        UIImageView *img = [[UIImageView alloc] init];
		img.layer.masksToBounds = YES;
        img.layer.borderWidth = 4;
        img.layer.cornerRadius = 7;
        img.layer.borderColor = [[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]CGColor]; 
		img.frame = CGRectMake(5+xOffset,1, 145, 110);
		scrollview.contentSize = CGSizeMake(scrollWidth+xOffset,115); 
        lazyImageView = [[DTLazyImageView alloc] initWithFrame:CGRectMake(1,1,141,106)];
        lazyImageView.delegate = self;
        lazyImageView.tag =i;
        lazyImageView.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGPATH,[imgarr objectAtIndex:i]]];
        lazyImageView.backgroundColor= [UIColor clearColor];
        [img addSubview:lazyImageView];
        
        if (!lazyImageView.image) 
        {
            [lazyImageView startLoading];
           lazyImageView.actv.frame = CGRectMake(56,40,30 ,30 );
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(5+xOffset,0, 160, 110);
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.accessibilityIdentifier =[imgarr objectAtIndex:i]; 
        [scrollview addSubview:imgback];
        [scrollview addSubview:img];
        [scrollview addSubview:button];
        scrollview.contentSize = CGSizeMake(scrollWidth+xOffset,115);
        xOffset += 157;
    }

}

- (void)imageDidLoad: (DTLazyImageView *) lazyImageView
{
    
}

- (void)viewDidUnload
{
    [self setScrollview:nil];
    [self setMainimageview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [scrollview release];
    [mainimageview release];
    [super dealloc];
}
- (IBAction)buttonClicked:(UIButton *)sender {

 
    [bigimage removeFromSuperview];
    bigimage = [[DTLazyImageView alloc] initWithFrame:CGRectMake(0, 0,303,278)];
    bigimage.delegate = self;
    bigimage.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMGPATH,sender.accessibilityIdentifier]];
    bigimage.backgroundColor= [UIColor clearColor];
    [mainimageview addSubview:bigimage];
    
    if (!bigimage.image) 
    {
        [bigimage startLoading];
        bigimage.actv.frame = CGRectMake(140,110 ,30,30);
    }
}

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
