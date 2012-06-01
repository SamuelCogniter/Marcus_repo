//
//  HomeVC.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeVC.h"
#import "ListBookVC.h"
#import "HelpVC.h"
#import "AppDelegate.h"
#import "SettingsVC.h"
#import "InfoVC.h"
#import "UsersGroupVC.h"

@implementation HomeVC

@synthesize nameString, userID;


#pragma mark - View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;  
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //self.navigationItem.title = @"Home";
    self.navigationController.navigationBarHidden = YES;
   
  
    
    self.view.userInteractionEnabled = FALSE;
    
    //Start the timer to remove the splash image from the screen after specified time interval
    splashTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 
                                                   target:self 
                                                 selector:@selector(removeSplashImage) 
                                                 userInfo:nil 
                                                  repeats:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
    //By default there is no user name exists at first
    userNameExists = NO;
    
    
    
    
    
    //By default the name of the user is Player 1, if no user is created till yet
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UserNameExists"] == nil)
    {
        [userNameButton setTitle:@"Player 1" forState:UIControlStateNormal];
        
        
        //Save the settings for Player 1 to be accessed in exercise view and settings view
        NSMutableDictionary *player1SettingsDict = [[NSMutableDictionary alloc] init];
        [player1SettingsDict setObject:@"1" forKey:@"WritingAreaBackgroundColor"];
        [player1SettingsDict setObject:@"1" forKey:@"SaveToPhotoAlbum"];
         
    }
    
    else //else default will be the last selected user
    {
        [userNameButton setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserNameExists"] forState:UIControlStateNormal];
        
        
        //User name exists, now fetch the details of this user from DB
        userNameExists = YES;
    }
    
    
    
    self.navigationController.navigationBarHidden = YES;
    
    
    
    
    
    //Prepare the query, so to fetch all the details of the user selected 
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    if (userNameExists)
    {
        //FETCH THE DETAILS OF THE USER BASED UPON HIS NAME FROM DB
        NSString *query =[NSString stringWithFormat:@"SELECT * FROM USERS WHERE USER_NAME=\'%@\'",[[NSUserDefaults standardUserDefaults] objectForKey:@"UserNameExists"]];
        
        [appDelegate fetchUsersDetailsFromDB:query];
        
        
        //Set the settings section value at here
        userID = appDelegate.userIdString;
        nameString = appDelegate.userNameString;
        backgroundColorString = appDelegate.backgroundColorString;
        savePhotoAlbumString = appDelegate.saveImageString;
        
        
        //Save users settings option in dictionary and then to user defaults to be used in other views
        NSMutableDictionary *settingsDict = [[NSMutableDictionary alloc] init];
        [settingsDict setObject:backgroundColorString forKey:@"WritingAreaBackgroundColor"];
        [settingsDict setObject:savePhotoAlbumString forKey:@"SaveToPhotoAlbum"];
        
        [[NSUserDefaults standardUserDefaults] setObject:settingsDict forKey:@"UserSettings"];
        
        
        
        NSLog(@"userId is %@",userID);
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"SelectedUSERID"];
        NSLog(@"user name is %@",nameString);
        NSLog(@"Background color is %@",backgroundColorString);
        NSLog(@"save photo album is %@",savePhotoAlbumString);
        
        
    }
    else
    {
        //NO USER FOUND, START THE APP FOR Player 1  AS A DEFAULT USER

    }
    
    
}



#pragma mark - Action Methods


//Remove the splash image from the screen

- (void)removeSplashImage
{
    if (splashImageView != nil)
    {
        [splashImageView removeFromSuperview];
    }
    
    self.view.userInteractionEnabled = YES;
}





//This method will push the user to UsersGroupVc to change/create new user
- (IBAction)changeUserButtonClicked:(id)sender
{
    UsersGroupVC *vc = [[UsersGroupVC alloc] initWithNibName:@"UsersGroupVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)instructionButtonClicked:(id)sender
{
    InfoVC *vc = [[InfoVC alloc] initWithNibName:@"InfoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)settingsButtonClicked:(id)sender
{
    SettingsVC *vc = [[SettingsVC alloc] initWithNibName:@"SettingsVC" bundle:nil];
    vc.bgColorString = backgroundColorString;
    vc.saveImageToPhotoAlbum = savePhotoAlbumString;
    vc.userIdStr=userID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (IBAction)selectBookButtonClicked:(id)sender
{
    
    ListBookVC *vc = [[ListBookVC alloc] initWithNibName:@"ListBookVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (IBAction)helpButtonClicked:(id)sender
{
    HelpVC *vc = [[HelpVC alloc] initWithNibName:@"HelpVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}






#pragma mark - Memory Management Methods

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - InterFace Orientation Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
