//
//  ModelClass.h
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"

@class DarckWaitView;

@interface ModelClass : NSObject {
    SBJsonParser *parser;
    SEL seignInSel;
    SEL signupSel;
    SEL useridSel;
    SEL locationUpdateSel;
    SEL getsweepsel;
    SEL getwinsel;
    SEL sweepdetsel;
    SEL getpoisel;
    SEL applysel;
    SEL forgetsel;
    SEL sweepload;
    SEL increase;
    SEL pushset;
    SEL synchro;
    SEL adcolonytkt;
    SEL menuuser;
    SEL getentry;
    //Entry methods releated Selectors
    SEL getentrymethodsSel;
    SEL getLogoSel;
    SEL enterInSweepStakeSel;
    SEL enterInSweepStakeSelAdColony;
    SEL getNumberOfEntriesSel;
    SEL vungleMoviePlayed;
    
    DarckWaitView *drk;
    DarckWaitView *drkSignUp;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) id returnData;
@property (nonatomic, readwrite) BOOL success;

- (void) signIn:(NSString *)email password:(NSString *)pasw deviceid:(NSString *)token selector:(SEL)sel;
- (void)signUpEmail:(NSString *)email password:(NSString *)pasw firstname:(NSString *)fname lastname:(NSString *)lname gender:(NSString *)gen refcode:(NSString *)ref fbuserid:(NSString *)fbuid photo:(NSString *)photo devietype:(NSString *)devtype devicetoken:(NSString *)token dob:(NSString *)dobStr selector:(SEL)sel;
- (void)Userinfo:(NSString *)userid start:(NSString *)st  selector:(SEL)sel;
- (void)Userinfosweeps:(NSString *)userid start:(NSString *)st  selector:(SEL)sel;
- (void)getsweeplist:(NSString *)userid  selector:(SEL)sel;
- (void)getwinnerlist:(NSString *)userid  selector:(SEL)sel;
- (void)Getdetailsweep:(NSString *)userid sweepid:(NSString *)sid  selector:(SEL)sel;
- (void)getpoint:(NSString *)userid  selector:(SEL)sel;
- (void)applypoint:(NSString *)userid sweepid:(NSString *)sid credits:(NSString *)credit selector:(SEL)sel;
- (void)forgetpass:(NSString *)email  selector:(SEL)sel;
- (void)increasepoint:(NSString *)userid sweepid:(NSString *)sid sharetype:(NSString *)type  selector:(SEL)sel;
- (void)pushonoff:(NSString *)userid push:(NSString *)push  selector:(SEL)sel;
- (void)increaseadcolonyticket:(NSString *)tickets userid:(NSString *)uid  selector:(SEL)sel;

//The entry method API call
- (void)getEntryMethodsFor:(NSString *)userid sweepid:(NSString *)sid  selector:(SEL)sel;
- (void)getLogoFor:(NSString *)sid userid:(NSString *) userid selector:(SEL)sel;
- (void)enterUser:(NSString *)userid inSweepstakes:(NSString *)sid forTask:(NSString *)taskid selector:(SEL)sel;
- (void) enterSTForAdNetworkUser:(NSString *)userid inSweepstakes:(NSString *)sid forNetwork:(NSString *) networkName selector:(SEL)sel;
- (void) getNumberOfEntriesForUser:(NSString *)userid forSweepstakes:(NSString *)sid selector:(SEL)sel;
-(void)menuuserdetail:(NSString *)userid selector:(SEL)sel;
- (void)getuserentries:(NSString *)userid sweepstakeid:(NSString *)sid  selector:(SEL)sel;
- (BOOL) validateEmail: (NSString *)candidate;
- (NSString *) getFunc:(NSURL *)url;
- (void)vungleMoviePlayed:(NSString *)user_id sweepstakeid:(NSString *)sweeps_id Taskid:(NSString *)task_id Otherentryoptions:(NSString *)other_entry_options selector:(SEL)sel;
- (void)updateUserLocationFor:(NSString *) userid withCity:(NSString *)city withState:(NSString *) state;

@end
