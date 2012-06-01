//
//  UsersGroupVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "/usr/include/sqlite3.h"
#import "AppDelegate.h"

@interface UsersGroupVC : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
{
    IBOutlet UIButton *backBtn;
    
    //IBOutlets
    IBOutlet UITableView *usersNameTableView;
    
    IBOutlet UIButton *editbutton;
    IBOutlet UIButton *confirmbutton;
    
    //Other Objects
    NSMutableArray *usersNameArray; //TableView datasource for user names present in DB
    NSMutableArray *usersIdArray;
    
    UITextField *userNameTextField;
    

    NSString *docsDir;
    NSArray *dirPaths;
    NSString  *databasePath;
    
    BOOL isEditMode; //To ensure whether user is in editable mode or not
    
    int rowIndex; //To know user has selected which row to edit
    
    sqlite3 *usersDB;
    
    NSString *userName;
    NSMutableArray *userDetailsArray;
    
        
    
    NSString *updatedUserName; 
    NSString *userIdForRenameUser;
    
    AppDelegate *appDelegate;
}

@property (nonatomic, strong) UITableView *usersNameTableView;

    //IBActions & Method
- (IBAction)deleteButtonClicked:(id)sender;
- (IBAction)renameButtonClicked:(id)sender;
- (IBAction)okButtonClicked:(id)sender;
-(IBAction)backbuttonClicked:(id)sender;

- (IBAction)editingButtonCalled:(id)sender;


- (void)removeSplashImage;
- (void)loadTheDefaultSettings;


@end
