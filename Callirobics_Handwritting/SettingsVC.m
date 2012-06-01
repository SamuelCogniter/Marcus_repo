//
//  SettingsVC.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsVC.h"

@implementation SettingsVC

@synthesize bgColorString,saveImageToPhotoAlbum,userIdStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //Hide the navigation bar
    self.navigationController.navigationBarHidden = YES;
    
    if (userIdStr != nil) 
    {
        
        NSLog(@"%@",userIdStr);
    }
 
    
    ////////////////BACKGROUND IMAGE SETTINGS////////////////////////////

    //Check what is the value is saved in database for background color for this user
    if ([bgColorString intValue] == 0)  
    {
        backgroundColorSelected = 0; 
        
    }
    else 
    {
        backgroundColorSelected = 1;
    }
    
    
    //Set the background image of button, which is selected as a background image of this user
    if (backgroundColorSelected == 0)
    {
        [bgWhiteButton setBackgroundImage:[UIImage imageNamed:@"whitebg_check"] forState:UIControlStateNormal];
        
        [bgYellowButton setBackgroundImage:[UIImage imageNamed:@"settingsYellowButton.png"] forState:UIControlStateNormal];
    }
    else 
    {
        [bgYellowButton setBackgroundImage:[UIImage imageNamed:@"whitebg_check"] forState:UIControlStateNormal];
        
        [bgWhiteButton setBackgroundImage:[UIImage imageNamed:@"bluebg.png"] forState:UIControlStateNormal];
    }
        

    //////////////////SAVE TO PHOTO ALBUM SETTINGS///////////////////////////////
    
    if ([saveImageToPhotoAlbum intValue] == 0)
    {
        [saveImageButton setBackgroundImage:[UIImage imageNamed:@"bluebg.png"] forState:UIControlStateNormal];
        
        toggleSaveImageToPhotoAlbumOption = 0;

    }
    else 
    {
        [saveImageButton setBackgroundImage:[UIImage imageNamed:@"whitebg_check.png"] forState:UIControlStateNormal];
        
        //Toggle the check/uncheck image of save image option
        toggleSaveImageToPhotoAlbumOption = 1;
        
    }
       
}


#pragma mark - Other Methods

- (IBAction)backButtonClicked:(id)sender
{
    
    //Save the settings in DB
    [appDelegate updateSettings:userIdStr Color:[NSString stringWithFormat:@"%d",backgroundColorSelected] saveImageToPhotoAlbum:[NSString stringWithFormat:@"%d",toggleSaveImageToPhotoAlbumOption]]; 
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)backgroundImageChange:(id)sender
{ 
     // app delegate for update method call
    
      appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([sender tag] == 1) //White button is clicked
    {
        
        [bgWhiteButton setBackgroundImage:[UIImage imageNamed:@"whitebg_check"] forState:UIControlStateNormal];
        
        [bgYellowButton setBackgroundImage:[UIImage imageNamed:@"settingsYellowButton.png"] forState:UIControlStateNormal];
        
        backgroundColorSelected = 0;
       
         
    }
    
    else //Yellow Button is clicked
    {
        
        [bgYellowButton setBackgroundImage:[UIImage imageNamed:@"whitebg_check.png"] forState:UIControlStateNormal];
        
        [bgWhiteButton setBackgroundImage:[UIImage imageNamed:@"bluebg.png"] forState:UIControlStateNormal];
        
        backgroundColorSelected = 1;

    }
}

- (IBAction)saveImageToPhotoAlbum:(id)sender
{
    toggleSaveImageToPhotoAlbumOption++;
    
    if (toggleSaveImageToPhotoAlbumOption %2 == 0)
    {
        [saveImageButton setBackgroundImage:[UIImage imageNamed:@"whitebg_check.png"] forState:UIControlStateNormal];
        
        toggleSaveImageToPhotoAlbumOption = 0;
    }
    else
    {
        [saveImageButton setBackgroundImage:[UIImage imageNamed:@"bluebg.png"] forState:UIControlStateNormal];
        
        toggleSaveImageToPhotoAlbumOption = 1;
    }
    
}


//- (IBAction)saveSettingsToUsersDB:(id)sender
//{
//    //Save the settings in DB
//    [appDelegate updateSettings:userIdStr Color:[NSString stringWithFormat:@"%d",backgroundColorSelected] saveImageToPhotoAlbum:[NSString stringWithFormat:@"%d",toggleSaveImageToPhotoAlbumOption]]; 
//}


#pragma mark - Memory Management Methods

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
