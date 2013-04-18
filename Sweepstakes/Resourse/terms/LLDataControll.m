//
//  LLDataControll.m
//  LumyLibWSp
//
//  Created by Stableflow on 29.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LLDataControll.h"



@implementation LLDataControll
@synthesize temp;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark Plist data {

- (void) saveDict:(NSDictionary *)dict toFile:(NSString *)file clear:(BOOL)cl {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:file];
	NSArray *arr = [NSArray arrayWithContentsOfFile:path];
	NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:arr];
    if (cl) {
        [mArray removeAllObjects];
    }
	[mArray addObject:dict];
	NSArray *pathsW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryW = [pathsW objectAtIndex:0];
    NSString *pathW = [documentsDirectoryW stringByAppendingPathComponent:file];
    [mArray writeToFile:pathW atomically:YES];
	[mArray release];
}

- (NSArray *) getSavedFromFile:(NSString *)file {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:file];
	return [NSArray arrayWithContentsOfFile:path];
	
}

- (void) deleteFile:(NSString *)file {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:file];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:NULL];
}

- (void) saveData:(id)data toFile:(NSString *)file {
	NSArray *pathsW = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryW = [pathsW objectAtIndex:0];
    NSString *pathW = [documentsDirectoryW stringByAppendingPathComponent:file];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:data];
    [data1 writeToFile:pathW atomically:YES];
}

- (id) getDataFromFile:(NSString *)file {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:file];
	return [NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:path]];
}

#pragma mark }


#pragma mark archive data {

- (void)saveData:(id)data toArchive:(NSString *)arshive {
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:data];
    
    [[NSUserDefaults standardUserDefaults] setObject:data1 forKey:arshive];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)getDataFromArchive:(NSString *)arshive {
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:arshive];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data2];
}

-(NSMutableArray*)getData{
    NSArray *myArray=[[NSArray alloc]init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *Path =[NSString stringWithFormat:@"%@/%@.plist",docDir,@"isLogin"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:Path])
    {
      //  NSLog(@"exist");
        myArray=[[NSArray alloc]initWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[NSData dataWithContentsOfFile:Path]]];
        return [NSMutableArray arrayWithArray:myArray];
    }
    else{
      //  NSLog(@"not exist");
        return nil;
    }
    //return myArray;
    
}

-(void)setData:(NSMutableArray*)dataArray{
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *Path =[NSString stringWithFormat:@"%@/%@.plist",docDir,@"isLogin"];
   // NSLog(@"%@",Path);
    BOOL didWriteSuccessfull = [data writeToFile:Path atomically:YES];
    if (didWriteSuccessfull) {
        NSLog(@"store succsessfully");
    }
    else {
        NSLog(@"Error in Storing");
    }

}
-(void)deleteData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"isLogin.plist"]];
   // NSLog(@"plistdeletepath->%@",fullPath);
    if([fileManager fileExistsAtPath:fullPath])
        [fileManager removeItemAtPath: fullPath error:NULL];
    
    
    
    
}

#pragma mark }

@end
