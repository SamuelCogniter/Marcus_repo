//
//  AppDelegate.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"


//static sqlite3_stmt *update_Stmt = nil;



@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

@synthesize navController;
@synthesize userIdArray,userNameArray;
@synthesize databasePath,dirPaths,docsDir;

@synthesize userIdString,userNameString,backgroundColorString,saveImageString, dbQueryStatus,book1_string,book2_string;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
  //////////////////////////////FETCH BOOKS COUNT FROM PLIST////////////////////////////
    
    
    //Fetch the books counts from plist so that we can create our loacl Database
    [self fetchBookCountsFromPlist];
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    
    
    
    
    ////////////////////////////// DATABASE //////////////////////////////    
    
    // Get the documents directory to fetch the path of the local db
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"USERS.sqlite"]];
    
    
    //Create the database to store all the users and thier settings and exercises information
    [self createDataBase];

    
    
    //////////////////////////////////////////////////////////////////////////////
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //Add UsersGroupVC as the first view of the application
    HomeVC *vc = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
    navController = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.window addSubview:navController.view];
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



//This method will fetch the books count from plist so that we can create column for the books dynamically
- (void)fetchBookCountsFromPlist
{
    ////////////////// Fetch the Books count from plist///////////////////////////////
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    // get documents path
    NSString *documentsPath = [paths objectAtIndex:0];
    // get the path to our Data/plist file
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Books.plist"];
    
    // check to see if Data.plist exists in documents
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        // if not in documents, get property list from main bundle
        plistPath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
    }
    
    
    //SAVE THE PLIST FETCHED FROM BUNDLE TO APPLICATION DOCUMENTS DIRECTORY
    NSError *error;
    NSArray *newPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [newPaths objectAtIndex:0];
    NSString *docDirPath = [documentsDirectory stringByAppendingPathComponent:@"Books.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath: docDirPath])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath:docDirPath error:&error];
        
        NSLog(@"plist is copied to Directory");
    }
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Books.plist"];

    
    // read property list into memory as an NSData object
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:path];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    
    // convert static property liost into dictionary object
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];        
   
    
    
    if (!temp)
    {
        // NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    else
    {
        NSLog(@"Dict is %@",temp);
        
        NSLog(@"Books count is %d",[[temp objectForKey:@"Books"] count]);
        
        NSString *booksCount = [NSString stringWithFormat:@"%d",[[temp objectForKey:@"Books"] count]];
        
        if ([[temp objectForKey:@"Books"] count] > 0)
        {
            
            
            NSString *users;
            myArray = [[NSMutableArray alloc] init];
            for (int i=0; i<[[temp objectForKey:@"Books"] count]; i++)
            {
                
                users = [NSString stringWithFormat:@"BOOK_%d TEXT",i+1];
                [myArray addObject:users];
            }
            
            //Save the books count in user defaults for further access in app
            [[NSUserDefaults standardUserDefaults] setObject:booksCount forKey:@"BOOKS_COUNT"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            NSMutableString *booksString = [[NSMutableString alloc] init];
            
            for (NSMutableString *tempStr in myArray)
            {
                
                [booksString appendFormat:[NSString stringWithFormat:@"%@,",tempStr]];
            }
            
            
            //It will remove the last comma from the string and dynamic query for the books is created now
            finalBookStr = [booksString substringToIndex:[booksString length]-1];
            NSLog(@"Final books are %@",finalBookStr);
            
            
            [[NSUserDefaults standardUserDefaults] setObject:finalBookStr forKey:@"plist_BOOKS"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
    }
    
    
    
}


- (void)createDataBase
{
    
    //If count is greater than zero then create our database
    if ([finalBookStr length] > 0)
    {
        
        ////////////////////////// USERS DATABASE QUERY///////////////////////////
        
        //This query is based upon the number of books available in plist
        NSString *dbQuery = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS USERS (USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, USER_NAME TEXT, BACKGROUND_SETTINGS_COLOR TEXT, SAVE_PHOTO_ALBUM TEXT, %@)",finalBookStr];
        
        
        if ([databasePath length] > 0) //DB path exists
        {
            
            NSFileManager *filemgr = [NSFileManager defaultManager];
            
            //Database not exists, create the database at 1st time
            if ([filemgr fileExistsAtPath: databasePath] == NO)
            {
                const char *dbpath = [databasePath UTF8String];
                
                if (sqlite3_open(dbpath, &usersDB) == SQLITE_OK)
                {
                    char *errMsg;
                    const char *sql_stmt = (char *)[dbQuery UTF8String];
                    NSLog(@"Query str is %s",sql_stmt);
                    
                    if (sqlite3_exec(usersDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
                    {
                        NSLog(@"Failed to create table");
                    }
                    
                    //sqlite3_close(usersDB);
                    
                }
                else //Failed to create/open the db, launch this pop up
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to open/create the database, Please relaunch the app again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
            }
            else 
            {
                NSString *query = @"SELECT * FROM USERS";
                [self fetchUsersDetailsFromDB:query];
                
            }
            
        }
        
    }
}



////////////////////////////     SELECT USER QUERY  ///////////////////////////////////////

//Fetch all users data from db - SELECT QUERY
- (void)fetchUsersDetailsFromDB:(NSString *)query
{
    userIdArray = [[NSMutableArray alloc] init];
    userNameArray = [[NSMutableArray alloc] init];
    
    if ([databasePath length] > 0)
    {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &usersDB) == SQLITE_OK)
        {		
            const char *sql = (char *)[query UTF8String];
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(usersDB, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
                
                while(sqlite3_step(selectstmt) == SQLITE_ROW) {
                    
                    //Fetch the user id
                    userIdString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)];				
                    
                    //Fetch the user name
                    userNameString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                    
                    //Fetch the background color 
                    backgroundColorString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                    
                    
                    //Fetch the Save image to photo gallery
                    saveImageString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
                    
                    
                    [userIdArray addObject:userIdString];
                    [userNameArray addObject:userNameString];
                    
                    NSLog(@"Save image str in app d is %@",saveImageString);
                    
                }
            }
        }
        else
            sqlite3_close(usersDB); //Even though the open call failed, close the database connection to release all the memory.
    }
}

//Fetch the book details from the DB....
- (void)fetchBOOKSDetailsFromDB:(NSString *)query
{
    
    //Generate as much Arrays according to Books Array Count 
    for (int j = 0 ; j <= [myArray count];j++)
    {

        
        
    }
    
    if ([databasePath length] > 0)
    {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &usersDB) == SQLITE_OK)
        {		
            const char *sql = (char *)[query UTF8String];
            sqlite3_stmt *selectstmt;
            if(sqlite3_prepare_v2(usersDB, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
                
                while(sqlite3_step(selectstmt) == SQLITE_ROW)
                {
                    
                    for (int i =0; i < [myArray count]; i++)
                    {
                        
                        
                        
                    }

                }
            }
        }
        else
            
            //Even though the open call failed, close the database connection to release all the memory.
            sqlite3_close(usersDB); 
    }

    
}

//////////////////////UPDATE FOR USER NAME according to user id //////////////////////////

- (void)updateUserName:(NSString *)userId name:(NSString *)userName

{
    // sqlite3 *database;
    const char *sqlStatement = [[NSString stringWithFormat:@"UPDATE USERS Set USER_NAME=? where USER_ID = %@",userId] UTF8String];
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(usersDB, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {     
        
        sqlite3_bind_text(compiledStatement, 1, [userName UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(compiledStatement))
        {
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(usersDB));
            
            dbQueryStatus = NO;
        }
        else 
        {
            dbQueryStatus = YES;
        }
        
        sqlite3_reset(compiledStatement);
    }
    // Release the compiled statement from memory
    sqlite3_finalize(compiledStatement);    
}

//UPDATE EXCERCISE STATUS DONE OR NOT, send userid, bookname, excercise id to store the value
- (void)update_ExcerciseStatus:(NSString *)userId Bookname:(NSString *)BookName ExcerciseID:(NSString *)ExcerciseNameId

{
    
    const char *sqlStatement = [[NSString stringWithFormat:@"UPDATE USERS Set %@=? where USER_ID = %@",BookName,userId] UTF8String];
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(usersDB, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {     
        
        sqlite3_bind_text(compiledStatement, 1, [ExcerciseNameId UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(compiledStatement))
        {
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(usersDB));
            
            dbQueryStatus = NO;
        }
        else 
        {
            dbQueryStatus = YES;
        }
        
        sqlite3_reset(compiledStatement);
    }
    // Release the compiled statement from memory
    sqlite3_finalize(compiledStatement);    
}





///////////////////     UPDATE FOR SETTINGS SECTION     /////////////////////////////////////

- (void)updateSettings:(NSString *)userId Color:(NSString *)backcolor saveImageToPhotoAlbum:(NSString *)saveImage
{
    const char *sqlStatement = [[NSString stringWithFormat:@"UPDATE USERS Set BACKGROUND_SETTINGS_COLOR=?,SAVE_PHOTO_ALBUM=? where USER_ID = %@",userId] UTF8String];
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(usersDB, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {     
        
        sqlite3_bind_text(compiledStatement, 1, [backcolor UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(compiledStatement, 2, [saveImage UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(compiledStatement))
        {
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(usersDB));
            
            dbQueryStatus = NO;
            
        }
        else 
        {
            dbQueryStatus = YES;
        }
        
        
        sqlite3_reset(compiledStatement);
    }
    // Release the compiled statement from memory
    sqlite3_finalize(compiledStatement);      
}






////////////////////////////     DELETE USER QUERY  ///////////////////////////////////////

-(void)delete_User:(NSString *)userId {
    {
        NSString *sql_str=[NSString stringWithFormat:@"DELETE FROM USERS where USER_ID = %d",[userId intValue]];
        const char *sql = [sql_str UTF8String];
        
        //  sqlite3 *database;
        
        if(sqlite3_open([databasePath UTF8String], &usersDB) == SQLITE_OK)
        {
            sqlite3_stmt *deleteStmt;
            if(sqlite3_prepare_v2(usersDB, sql, -1, &deleteStmt, NULL) == SQLITE_OK)
            {
                
                if(sqlite3_step(deleteStmt) != SQLITE_DONE )
                {
                    NSLog( @"Error: %s", sqlite3_errmsg(usersDB) );
                    
                    //Error 
                    dbQueryStatus = NO;
                }
                else
                {
                    //  NSLog( @"row id = %d", (sqlite3_last_insert_rowid(database)+1));
                    NSLog(@"No Error");
                    dbQueryStatus = YES;
                }
            }
            sqlite3_finalize(deleteStmt);
        }
        sqlite3_close(usersDB);
    }
   // [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"UserNameExists"];
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Callirobics_Handwritting" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Callirobics_Handwritting.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
