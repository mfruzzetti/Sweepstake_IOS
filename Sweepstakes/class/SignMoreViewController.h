//
//  SignMoreViewController.h
//  Sweepstakes
//
//  Created by Kuldeep Bhatt on 3/13/13.
//  Copyright (c) 2013 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelClass.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "Toast+UIView.h"
#import "LLDataControll.h"
@class ActionSheetDatePicker;

@interface SignMoreViewController : UIViewController
{
        ModelClass *mc;
    //NSString *firstNameStr,*lastNameStr,*emailStr,*passwordStr;
    IBOutlet UIButton *btfemale;
    IBOutlet UIButton *btmale;
    NSString *gender;
    IBOutlet UITextField *dateOfBirth;
    ActionSheetDatePicker *actionSheetView;
    IBOutlet UITextField *referralCodeField;
    LLDataControll *dc;
    IBOutlet UIImageView *referralCodeImgv;
    IBOutlet UIImageView *dateOfBirthTickImgv;
    IBOutlet UIImageView *selectionDotImgvM;
    IBOutlet UIImageView *selectionDotImgvF;
    IBOutlet UIImageView *centreDotImgv;
}

@property(nonatomic,assign)NSString *firstNameStr, *lastNameStr, *emailStr, *passwordStr, *dobStr;

@end



@interface ActionSheetDatePicker : NSObject <UIPickerViewDelegate,UIActionSheetDelegate>
{
	UIActionSheet *actionSheet;
	id target;
	SEL action;
	NSString *setTime;
    bool bBirthDatePickerValueChanged;

}
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, retain) id target;
@property (nonatomic, assign) SEL action;
@property (nonatomic) bool bBirthDatePickerValueChanged;

-(void)ShowActionPickerInView:(UIViewController*)inViewController;
-(id)initWithTarget:(id)target_ withSelector:(SEL)selector_  withsetTime:(NSString *)time_;
@end