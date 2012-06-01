//
//  SettingsVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "HomeVC.h"
#import "sqlite3.h"


@interface SettingsVC : UIViewController
{
    
    //IBOutlets
    
    IBOutlet UIButton *bgWhiteButton;
    IBOutlet UIButton *bgYellowButton;
    IBOutlet UIButton *saveImageButton;
    
    
    NSString *bgColorString;
    NSString *saveImageToPhotoAlbum;
    
    int backgroundColorSelected;
    int saveToPhotoAlbum;
    int toggleSaveImageToPhotoAlbumOption;
    
    AppDelegate *appDelegate;
    
    
    NSString *userIdStr;
    
    
    sqlite3 *usersDB;

}

@property (nonatomic, strong) NSString *bgColorString;
@property (nonatomic, strong) NSString *saveImageToPhotoAlbum;
 @property (nonatomic, strong) NSString *userIdStr;


//IBActions & Methods
- (IBAction)backButtonClicked:(id)sender;

- (IBAction)backgroundImageChange:(id)sender;
- (IBAction)saveImageToPhotoAlbum:(id)sender;

- (IBAction)saveSettingsToUsersDB:(id)sender;


@end
