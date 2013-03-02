//
//  DatabaseManager.m
//  For_Your_Life
//
//  Created by Dang Anh Tuan on 2013/03/02.
//  Copyright (c) 2013年 Dang Anh Tuan. All rights reserved.
//

#import "DatabaseManager.h"


@implementation DatabaseManager

+ (id)dbConnect
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Sample.db"];
	BOOL success = [fileManager fileExistsAtPath:writableDBPath];
	if(!success){
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Sample.db"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        NSLog(@"DB connect success");
	}
	if(!success){
		NSAssert1(0, @"failed to create writable db file with message '%@'.", [error localizedDescription]);
	}
    
    FMDatabase* db = [FMDatabase databaseWithPath:writableDBPath];
    if(![db open])
    {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
    
    [db setShouldCacheStatements:YES];
    
    return db;
}

@end
