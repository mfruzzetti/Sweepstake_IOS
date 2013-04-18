//
//  AccountLoginVC.h
//  Sweepstakes
//
//  Created by Kuldeep Bhatt on 3/13/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClass.h"
#import "LLDataControll.h"


@interface AccountLoginVC : UIViewController
{
    ModelClass *mc;
    LLDataControll *dc;
    
    UILabel *forgotpasslb;
    UITextField *emailtextfield;
    UITextField *passwordtextfield;
    UIScrollView *scrollview;
}
@property (retain, nonatomic) IBOutlet UILabel *forgotpasslb;
@property (retain, nonatomic) IBOutlet UITextField *emailtextfield;
@property (retain, nonatomic) IBOutlet UITextField *passwordtextfield;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
@end
