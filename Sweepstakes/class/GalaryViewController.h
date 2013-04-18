//
//  GalaryViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 22/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTLazyImageView.h"
#import "Quartzcore/Quartzcore.h"

@interface GalaryViewController : UIViewController<UIScrollViewDelegate,DTLazyImageViewDelegate>{
    NSMutableArray *imgarr;
    DTLazyImageView *lazyImageView;
    DTLazyImageView *bigimage;
    
}
@property (retain, nonatomic) NSMutableArray *imgarr;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@property (retain, nonatomic) IBOutlet UIImageView *mainimageview;
- (IBAction)goback:(id)sender;

@end
