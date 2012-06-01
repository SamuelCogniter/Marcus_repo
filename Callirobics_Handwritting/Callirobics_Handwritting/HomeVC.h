//
//  HomeVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController
{
    
    //IBOutlets
    IBOutlet UIButton *userNameButton;
    
    
    IBOutlet UIButton *instructionsButton;
    IBOutlet UIButton *selectBookButton;
    IBOutlet UIButton *moreInformationButton;
    
    IBOutlet UIImageView *splashImageView;

    
    //Selected users values
    NSString *nameString;
    NSString *userID;
    NSString *backgroundColorString;
    NSString *savePhotoAlbumString;

    
    NSTimer *splashTimer;
    
    BOOL userNameExists; //To make query to fetch the details of selected user
    
    
}
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSString *userID;



//IBActions

- (IBAction)instructionButtonClicked:(id)sender;
- (IBAction)selectBookButtonClicked:(id)sender;
- (IBAction)helpButtonClicked:(id)sender;
- (IBAction)settingsButtonClicked:(id)sender;
- (IBAction)changeUserButtonClicked:(id)sender;

@end
