//
//  Utility.m
//  MyFirstApplication
//
//  Created by Peerbits Solution on 15/05/12.
//  Copyright (c) 2012 info@peerbits.com. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(NSString *) getDatabasePath
{
    NSString *databasePath = [(AppDelegate*)[[UIApplication sharedApplication] delegate] databasePath];
    
    return databasePath; 
}

+(void) showAlert:(NSString *)title message:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

@end
