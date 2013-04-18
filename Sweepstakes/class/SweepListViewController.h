//
//  SweepListViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 05/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/Quartzcore.h"
#import "DTLazyImageView.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "SweepDetailViewController.h"
#import "ModelClass.h"
#import "ViewController.h"
#import "LLDataControll.h"
#import "DDMenuController.h"

@interface SweepListViewController : UIViewController<DTLazyImageViewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,DDMenuControllerDelegate>{

    DTLazyImageView *lazyImageView;
    NSMutableArray *imagearry;
    NSMutableArray *titlenamearray;
    NSMutableArray *sweepidarray;
    NSMutableArray *productprizearray;
    NSMutableArray *timearray;
    NSMutableArray *timestamparray;
    NSMutableArray *catidarray;
    NSMutableArray *filtersweepidarr;
    NSString *usrid;
    ModelClass *mc;
    UILabel *plus;
    UILabel *credit;
    IBOutlet UIButton *pricebtn;
    IBOutlet UIButton *timebtn;
    IBOutlet UIButton *giftcardbtn;
    IBOutlet UIButton *travelbtn;
    IBOutlet UIButton *ticketbtn;
    IBOutlet UIButton *cashbtn;
    IBOutlet UIButton *shoppingbtn;
    IBOutlet UIButton *eventbtn;
    NSString *pricetime;
    NSMutableArray *catidstrarr;
    IBOutlet UITableView *listingtable;
  //  NSTimer *timer;
    LLDataControll *dc;
   
    
    
}

@property (retain, nonatomic) IBOutlet UIView *view2;
@property (retain, nonatomic) IBOutlet UILabel *categorieslb;
@property (retain, nonatomic) IBOutlet UILabel *sortbylb;
@property (retain, nonatomic) IBOutlet UILabel *sweeplb;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *creditlb;
@property (retain, nonatomic) IBOutlet UILabel *sortfilterlbl;
@property (retain, nonatomic) NSString *usrid;
@property (retain, nonatomic) IBOutlet UIButton *backbtn;
- (IBAction)priceaction:(id)sender;
- (IBAction)timeaction:(id)sender;
- (IBAction)giftcardaction:(id)sender;
- (IBAction)travelaction:(id)sender;
- (IBAction)ticketaction:(id)sender;
- (IBAction)cashaction:(id)sender;
- (IBAction)shoppingaction:(id)sender;
- (IBAction)eventsaction:(id)sender;
- (IBAction)sortclose:(id)sender;
- (IBAction)refreshresult:(id)sender;




@end
