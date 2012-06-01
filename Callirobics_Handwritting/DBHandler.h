//
//  DBHandler.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBHandler : NSObject
{
    //sqlite3 *usersDB;

    //Variables to hold the db path parameters
    NSString *docsDir;
    NSArray *dirPaths;
    
    NSMutableArray *userNameArray;
}

@property(strong, nonatomic) NSString *docsDir;
@property(strong, nonatomic) NSArray *dirPaths;


+ (void)fetchDataFromUsersTable:(NSString *)query; 

@end
