//
//  WinnerlistViewController.h
//  Sweepstakes
//
//  Created by Peerbits Solution on 05/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quartzcore/Quartzcore.h"
#import "FMDatabase.h"
#import "FMDBDataAccess.h"
#import "FMResultSet.h"
#import "Entities.h"
#import "ModelClass.h"
#import "ViewController.h"
#import "DDMenuController.h"
#import "LLDataControll.h"
@interface WinnerlistViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,DDMenuControllerDelegate>{


    ModelClass *mc;
    IBOutlet UITableView *winnerstableview;
    IBOutlet UIButton *thiswkbtn;
    IBOutlet UIButton *lastwkbtn;
    IBOutlet UIButton *custwkbtn;
    NSMutableArray *images;
    UILabel *credit;
    UILabel *plus;
    NSString *lastmonthcount;
    NSString *lastweekcount;
    NSString *thisweekcount;
    NSMutableArray *twnamearray;
    NSMutableArray *twprizearray;
    NSMutableArray *twtimearray;
    NSMutableArray *twtitlearray;
    
    NSMutableArray *lwnamearray;
    NSMutableArray *lwprizearray;
    NSMutableArray *lwtimearray;
    NSMutableArray *lwtitlearray;
    
    NSMutableArray *lmnamearray;
    NSMutableArray *lmprizearray;
    NSMutableArray *lmtimearray;
    NSMutableArray *lmtitlearray;
    DDMenuController *_menuController;
    LLDataControll *dc;
}
- (IBAction)thisweekpress:(id)sender;
- (IBAction)lastweekpress:(id)sender;
- (IBAction)customweekpress:(id)sender;
- (IBAction)goback:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *creditlb;
@property (retain, nonatomic) NSString *userid;
@property (retain, nonatomic) IBOutlet UIButton *backbtn;



@end
