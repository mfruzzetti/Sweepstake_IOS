//
//  Utility.h
//  MyFirstApplication
//
//  Created by Peerbits Solution on 15/05/12.
//  Copyright (c) 2012 info@peerbits.com. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "AppDelegate.h"


@interface Utility : NSObject
{
    
}

+(NSString *) getDatabasePath;

+(void) showAlert:(NSString *) title message:(NSString *) msg; 

@end
