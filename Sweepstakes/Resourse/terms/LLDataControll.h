//
//  LLDataControll.h
//  LumyLibWSp
//
//  Created by Stableflow on 29.06.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LLDataControll : NSObject {
    
    NSNumber *temp;
    
}

@property (nonatomic,assign) NSNumber *temp;


- (void) saveDict:(NSDictionary *)dict toFile:(NSString *)file clear:(BOOL)cl;
- (NSArray *) getSavedFromFile:(NSString *)file;
- (void) deleteFile:(NSString *)file;

- (void) saveData:(id)data toFile:(NSString *)file;
- (id) getDataFromFile:(NSString *)file;

- (void)saveData:(id)data toArchive:(NSString *)arshive;
- (id)getDataFromArchive:(NSString *)arshive;
-(void)setData:(NSMutableArray*)dataArray;
-(NSMutableArray*)getData;
-(void)deleteData;
@end
