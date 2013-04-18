//
//  ModelClass.m
//  APITest
//
//  Created by Evgeny Kalashnikov on 03.12.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ModelClass.h"
#import "ASIFormDataRequest.h"
#import "DarckWaitView.h"

@implementation ModelClass

@synthesize delegate = _delegate;

@synthesize success;
@synthesize returnData = _returnData;

- (id)init
{
    self = [super init];
    if (self) {
        parser = [[SBJsonParser alloc] init];
        success = NO;
        drk = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
        drkSignUp = [[DarckWaitView alloc] initWithDelegate:nil andInterval:0.1 andMathod:nil];
    }
    
    return self;
}


- (void) signIn:(NSString *)email password:(NSString *)pasw deviceid:(NSString *)token selector:(SEL)sel {
    if ([self validateEmail:email] && [pasw length]) {
        seignInSel = sel;
        //NSLog(@"The token value is -> %@", token);
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/login",API_PATH]];    
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setPostValue:email forKey:@"email"];
        [request setPostValue:pasw forKey:@"password"];
        [request setPostValue:token forKey:@"device_id"];
        //[request setPostValue:@"Test data" forKey:@"test_var"];
        [request setDelegate:self];
        [request startAsynchronous];
        [drkSignUp showWithMessage:nil];
    } else {
       
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Incorrect Email ID!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
    }
}
- (void)signUpEmail:(NSString *)email password:(NSString *)pasw firstname:(NSString *)fname lastname:(NSString *)lname gender:(NSString *)gen refcode:(NSString *)ref fbuserid:(NSString *)fbuid photo:(NSString *)photo devietype:(NSString *)devtype devicetoken:(NSString *)token dob:(NSString *)dobStr selector:(SEL)sel {
    
    if ([self validateEmail:email]) 
    {
        signupSel = sel;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/adduser",API_PATH]];    
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        [request setPostValue:email forKey:@"email"];
        [request setPostValue:pasw forKey:@"password"];
        [request setPostValue:fname forKey:@"first_name"];
        [request setPostValue:lname forKey:@"last_name"];
        [request setPostValue:gen forKey:@"gender"];
        [request setPostValue:fbuid forKey:@"facebook_id"];
        [request setPostValue:ref forKey:@"ref_id"];
        [request setPostValue:photo forKey:@"image"];
        [request setPostValue:devtype forKey:@"device_type"];
        [request setPostValue:token forKey:@"device_id"];
        [request setPostValue:dobStr forKey:@"dob"];
        
        [request setDelegate:self];
        [request startAsynchronous];
        [drkSignUp showWithMessage:nil];
    } else {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"Failed!" message:@"Incorest Email ID!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [al show];
        [al release];
    }
    
}
- (void)Userinfo:(NSString *)userid start:(NSString *)st  selector:(SEL)sel {
    useridSel =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/userinfo",API_PATH]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:st forKey:@"start"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
}

/*- (void)updateUserLocationFor:(NSString *) userid withCity:(NSString *)city withState:(NSString *) state selector:(SEL)sel {
    locationUpdateSel = sel;
}*/

- (void)updateUserLocationFor:(NSString *) userid withCity:(NSString *)city withState:(NSString *) state {
    NSLog(@"UPDATE LOCATION CALLED");
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/updatelocation", API_PATH]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:city forKey:@"city"];
    [request setPostValue:state forKey:@"state"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)Userinfosweeps:(NSString *)userid start:(NSString *)st  selector:(SEL)sel {
    sweepload =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/usersweeps",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:st forKey:@"start"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
}
-(void)menuuserdetail:(NSString *)userid selector:(SEL)sel{
    menuuser =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/usermenu",API_PATH]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];



}


- (void)getsweeplist:(NSString *)userid  selector:(SEL)sel {
     getsweepsel=sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/getlist",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
    
}

- (void)getwinnerlist:(NSString *)userid  selector:(SEL)sel{
    getwinsel=sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/SweepUsers/winnerlist",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
    
}
- (void)Getdetailsweep:(NSString *)userid sweepid:(NSString *)sid  selector:(SEL)sel {
    sweepdetsel = sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/check",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:sid forKey:@"sweepstakes_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

- (void)getpoint:(NSString *)userid  selector:(SEL)sel {
    getpoisel =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/getpoint",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
}
- (void)applypoint:(NSString *)userid sweepid:(NSString *)sid credits:(NSString *)credit selector:(SEL)sel {
    applysel = sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/SweepUsers/applypoints",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:sid forKey:@"sweepstakes_id"];
    [request setPostValue:credit forKey:@"credits"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

- (void)forgetpass:(NSString *)email selector:(SEL)sel {
    forgetsel =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/forgetpassword",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:email forKey:@"email"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
}


- (void)increasepoint:(NSString *)userid sweepid:(NSString *)sid sharetype:(NSString *)type  selector:(SEL)sel {
    increase =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/incresepoint",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:sid forKey:@"sweepstakes_id"];
    [request setPostValue:type forKey:@"type"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
}

- (void)pushonoff:(NSString *)userid push:(NSString *)push  selector:(SEL)sel {
    pushset =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/pushonoff",API_PATH]];    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:push forKey:@"user_push"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
}

- (void)increaseadcolonyticket:(NSString *)tickets userid:(NSString *)uid  selector:(SEL)sel {
    adcolonytkt =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/users/increasecredit",API_PATH]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:uid forKey:@"userid"];
    [request setPostValue:tickets forKey:@"point"];
    [request setDelegate:self];
    [request startAsynchronous];
   [drkSignUp showWithMessage:nil];
    

    
}
- (void)getuserentries:(NSString *)userid sweepstakeid:(NSString *)sid  selector:(SEL)sel {
    getentry =sel;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/getuserpoint",API_PATH]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"userid"];
    [request setPostValue:sid forKey:@"sweepstakes_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
    
    
    
}


/**
 Get all the entry methods
 */
- (void)getEntryMethodsFor:(NSString *)userid sweepid:(NSString *)sid  selector:(SEL)sel {
    getentrymethodsSel = sel;
    //The URL to call in order to retrieve the entry methods JSON
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/getdynamicentrymethods",API_PATH]];
    
    //Let's format the POST request
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"user_id"];
    [request setPostValue:sid forKey:@"sweeps_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

/**
 Get the logo for the sweepstakes
 */
- (void)getLogoFor:(NSString *)sid userid:(NSString *) userid selector:(SEL)sel {
    getLogoSel = sel;
    //NSLog(@"Logo method is called");
    //The URL to call in order to retrieve the Logo
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/getlogo", API_PATH]];
    
    //Let's format the POST request
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"user_id"];
    [request setPostValue:sid forKey:@"sweeps_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

/**
 Enters the user in the sweepstakes for the task id
 */
- (void) enterUser:(NSString *)userid inSweepstakes:(NSString *)sid forTask:(NSString *)taskid selector:(SEL)sel {
    enterInSweepStakeSel = sel;
    //The URL to call in order to retrieve the Logo
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/entersweepstakes", API_PATH]];
    //Let's format the POST request
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"user_id"];
    [request setPostValue:sid forKey:@"sweeps_id"];
    [request setPostValue:taskid forKey:@"task_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

/**
 Enters the user in the sweepstakes for the ad colony task
 */
- (void) enterSTForAdNetworkUser:(NSString *)userid inSweepstakes:(NSString *)sid forNetwork:(NSString *) networkName selector:(SEL)sel {
    enterInSweepStakeSelAdColony = sel;
    //The URL to call in order to retrieve the Logo
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/adnetwork_ios_callback", API_PATH]];
    //Let's format the POST request
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"user_id"];
    [request setPostValue:sid forKey:@"sweeps_id"];
    [request setPostValue:networkName forKey:@"network_name"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

//Fetches the total number of entries for a particular user for a particular sweepstakes
- (void) getNumberOfEntriesForUser:(NSString *)userid forSweepstakes:(NSString *)sid selector:(SEL)sel {
    getNumberOfEntriesSel = sel;
    //The URL to call in order to retrieve the Logo
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/getentries_ios", API_PATH]];
    //Let's format the POST request
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:userid forKey:@"user_id"];
    [request setPostValue:sid forKey:@"sweeps_id"];
    [request setDelegate:self];
    [request startAsynchronous];
    [drkSignUp showWithMessage:nil];
}

- (void)vungleMoviePlayed:(NSString *)user_id sweepstakeid:(NSString *)sweeps_id Taskid:(NSString *)task_id Otherentryoptions:(NSString *)other_entry_options selector:(SEL)sel{
    
    vungleMoviePlayed = sel;
    //The URL to call in order to retrieve the Logo
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.sweepstakesapp.net/api/sweeps/entersweepstakes"]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/sweeps/entersweepstakes", API_PATH]];
    //Let's format the POST request
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setPostValue:user_id forKey:@"user_id"];
    [request setPostValue:sweeps_id forKey:@"sweeps_id"];
    [request setPostValue:@"0" forKey:@"task_id"];
    [request setPostValue:@"vungle_vid" forKey:@"other_entry_options"];
    [request setDelegate:self];
    [request startAsynchronous];
    //[drkSignUp showWithMessage:nil];
}


- (BOOL) validateEmail: (NSString *)candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:candidate];
}
 

- (void)requestFinished:(ASIHTTPRequest *)request {
    
  
    
    NSString *func = [self getFunc:[request url]];
    
  
    
    
    if ([func isEqual:@"entersweepstakes"]) {
        //  NSLog(@"The raw response is -> %@", [request responseString]);
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:vungleMoviePlayed withObject:results];
        [drkSignUp hide];
    }
    if ([func isEqual:@"login"]) {
      //  NSLog(@"The raw response is -> %@", [request responseString]);
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:seignInSel withObject:results];
        [drkSignUp hide];
    }
    
    
    if ([func isEqual:@"adduser"]) {
        
       
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        NSLog(@"SIOGN UP RESULT =---> %@", results);
        
        [self.delegate performSelector:signupSel withObject:results];
        [drkSignUp hide];

    }
    
    if ([func isEqual:@"userinfo"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        //NSLog(@"The user info as it comes %@", results);
        [self.delegate performSelector:useridSel withObject:results];
        [drkSignUp hide];
        
    }
    if ([func isEqual:@"getlist"]) {
    
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
       
        [self.delegate performSelector:getsweepsel withObject:results];
        [drkSignUp hide];
    }
    if ([func isEqual:@"winnerlist"]) {
    
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
       
        [self.delegate performSelector:getwinsel withObject:results];
        [drkSignUp hide];
    }
    if ([func isEqual:@"check"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        //NSLog(@"THE SWEEPS DETAILS RESULT --> %@",results);
        [self.delegate performSelector:sweepdetsel withObject:results];
        [drkSignUp hide];
    }

    if ([func isEqual:@"getpoint"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        [self.delegate performSelector:getpoisel withObject:results];
        [drkSignUp hide];
    }

    if ([func isEqual:@"applypoints"]) {
         NSLog(@"%@",[request responseString]);
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        NSLog(@"%@",results);
        [self.delegate performSelector:applysel withObject:results];
        [drkSignUp hide];
         
    }
    
    if ([func isEqual:@"forgetpassword"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
    
        [self.delegate performSelector:forgetsel withObject:results];
        [drkSignUp hide];
    }
    if ([func isEqual:@"usersweeps"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
      
        [self.delegate performSelector:sweepload withObject:results];
        [drkSignUp hide];
    }
    
    if ([func isEqual:@"incresepoint"]) {
       
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
      
        [self.delegate performSelector:increase withObject:results];
        [drkSignUp hide];
    }

    if ([func isEqual:@"pushonoff"]) {
      
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
     
        [self.delegate performSelector:pushset withObject:results];
        [drkSignUp hide];
    }

    if ([func isEqual:@"increasecredit"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
       
        [self.delegate performSelector:adcolonytkt withObject:results];
        [drkSignUp hide];
    }

    //The handler for the entry method
    if ([func isEqual:@"getdynamicentrymethods"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:getentrymethodsSel withObject:results];
        [drkSignUp hide];
    }
    
    //The handler for the get logo method
    if ([func isEqual:@"getlogo"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:getLogoSel withObject:results];
        [drkSignUp hide];
    }
    
    //The handler for the entyer in sweepstakes method
    if ([func isEqual:@"entersweepstakes"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:enterInSweepStakeSel withObject:results];
        [drkSignUp hide];
    }
    
    //The handler for the enter in sweepstakes for ad colony video
    if ([func isEqual:@"adnetwork_ios_callback"]) {
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:enterInSweepStakeSelAdColony withObject:results];
        [drkSignUp hide];
    }
    
    //The handler for the getTotalEntries
    if ([func isEqual:@"getentries_ios"]) {
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        
        [self.delegate performSelector:getNumberOfEntriesSel withObject:results];
        [drkSignUp hide];
    }
    
    if ([func isEqual:@"usermenu"]) {
        NSLog(@"The response from the get total entries API call is --> @%@", [request responseString]);
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
        // NSLog(@"%@",results);
        [self.delegate performSelector:menuuser withObject:results];
        [drkSignUp hide];
    }
    if ([func isEqual:@"getuserpoint"]) {
        
        NSDictionary *results = [parser objectWithString:[request responseString] error:nil];
       // NSLog(@"%@",results);
        [self.delegate performSelector:getentry withObject:results];
        [drkSignUp hide];
    }


    
}


- (NSString *) getFunc:(NSURL *)url {
    NSString *str = [NSString stringWithFormat:@"%@",url];
    NSArray *arr = [str componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"/"]];
    return [arr lastObject];
}

@end
