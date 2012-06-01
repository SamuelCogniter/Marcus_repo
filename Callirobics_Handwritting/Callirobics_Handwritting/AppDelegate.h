//
//  AppDelegate.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navController;
    
    
    NSString *databasePath;
    NSString *finalBookStr;
    
    sqlite3 *usersDB;
    
    
    
    //Variables to hold the db path parameters
    NSString *docsDir;
    NSArray *dirPaths;
    
    
    //String to fetch the values from DB
    NSString *userIdString;
    NSString *userNameString;
    NSString *backgroundColorString;
    NSString *saveImageString;
    NSString *book1_string;
    NSString *book2_string;
    
    
    //Arrays to hold the user names and id from the db, to load the users in UsersGroupVC
    NSMutableArray *userIdArray;
    NSMutableArray *userNameArray;
    
    
    
    BOOL dbQueryStatus; //To track whether query is implemented successfully or not
    
    NSMutableArray *myArray; //Plist books array 
    
    
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) NSMutableArray *userIdArray;
@property (strong, nonatomic) NSMutableArray *userNameArray;


@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) NSString *docsDir;
@property (strong, nonatomic) NSArray *dirPaths;

@property (strong, nonatomic) NSString *userIdString;
@property (strong, nonatomic) NSString *userNameString;
@property (strong, nonatomic) NSString *backgroundColorString;
@property (strong, nonatomic) NSString *saveImageString;
@property (strong, nonatomic) NSString *book1_string;
@property(strong, nonatomic) NSString *book2_string;

@property (assign, nonatomic) BOOL dbQueryStatus;





- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


- (void)loadHomeView;

//This method will fetch the number of books from plist
- (void)fetchBookCountsFromPlist; 

//This method will create the database for the users to maitain all their activities throughout the app
- (void)createDataBase; 

//Method to fetch the user details from the db
- (void)fetchUsersDetailsFromDB:(NSString *)query;

//Update user name when user change the username in Usergroup class
- (void)updateUserName:(NSString *)userId name:(NSString *)userName;

//Method to updatet the  user excercises when user finished the excercise
- (void)update_ExcerciseStatus:(NSString *)userId Bookname:(NSString *)BookName ExcerciseID:(NSString *)ExcerciseNameId;

//Method to fetch the books details from the db
- (void)fetchBOOKSDetailsFromDB:(NSString *)query;

//update the application settings in the db
- (void)updateSettings:(NSString *)userId Color:(NSString *)backcolor saveImageToPhotoAlbum:(NSString *)saveImage;

//Delete the user from the db
-(void)delete_User:(NSString *)userId;

@end
