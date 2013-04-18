//
//  FMDBDataAccess.h
//  MyFirstApplication
//
//  Created by Peerbits Solution on 15/05/12.
//  Copyright (c) 2012 info@peerbits.com. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Entities.h"
#import "Utility.h" 
#import "FMDatabase.h"

@interface FMDBDataAccess : NSObject
{
    
}

-(NSMutableArray *) getCustomers; 
//-(BOOL) insertCustomer:(Entities *) customer; 
//-(BOOL) updateCustomer:(Entities *) customer; 

@end
