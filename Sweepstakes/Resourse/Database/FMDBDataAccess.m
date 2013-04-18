//
//  FMDBDataAccess.m
//  MyFirstApplication
//
//  Created by Peerbits Solution on 15/05/12.
//  Copyright (c) 2012 info@peerbits.com. All rights reserved.
//

#import "FMDBDataAccess.h"



@implementation FMDBDataAccess




-(NSMutableArray *) getCustomers
{
    NSMutableArray *customers = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[Utility getDatabasePath]];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:@"SELECT * FROM DETAILS"];
    
    while([results next]) 
    {
        Entities *entities = [[Entities alloc] init];
        
        
        entities.def = [results      stringForColumn:@"name"];
        entities.image = [results      stringForColumn:@"image"];
        
        [customers addObject:entities];
        
    }
    
    [db close];
    
    
    
    return customers; 
    
}

@end
