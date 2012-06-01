//
//  DBHandler.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBHandler.h"
#import "AppDelegate.h"

static sqlite3 *usersDB = nil;


@implementation DBHandler

@synthesize docsDir,dirPaths;

+ (void)fetchDataFromUsersTable:(NSString *)query 
{
    AppDelegate *appD = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
		
    if ([appD.databasePath length] > 0)
    {
        const char *dbpath = [appD.databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &usersDB) == SQLITE_OK)
        {		
            const char *sql = (char *)[query UTF8String];
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(usersDB, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
                
                while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                    
                    //Fetch the user id
                    NSString *userId = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];				
                    
                    //Fetch the user name
                    NSString *UserName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                    

                    //Remove all the previous objects first before storing new data
                    [appD.userIdArray removeAllObjects];
                    [appD.userNameArray removeAllObjects];
                    
                    
                    [appD.userNameArray addObject:UserName];
                    [appD.userIdArray addObject:userId];

                    
                }
            }
        }
        else
            sqlite3_close(usersDB); //Even though the open call failed, close the database connection to release all the memory.
    }}


@end
