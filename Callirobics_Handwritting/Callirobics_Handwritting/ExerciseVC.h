//
//  ExerciseVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>

@interface ExerciseVC : UIViewController<AVAudioPlayerDelegate>
{
    //IBOutlets
    
    IBOutlet UIImageView *sketchImageBackground;
    
    
    NSString *audioFile;   //Name of the intro audio file to be played
    NSString *coloredImageString; //Name of the 1st image,displayed when view loads
    NSString *exerciseMainImageString;//Name of the main image, where the path willl be followed
    NSString *exerciseTracingString; //name of the drawing image area
    NSString *mainAudioFile; //Name of the main audio file to be played
    
    int exerciseSelected; //To know which exercise user has choosen
    
    
    
    AVAudioPlayer *player;  //To play only the intro music file
    AVAudioPlayer *mainAudioPlayer; //To play the ex. main audio file
    
    
    
    UIImageView *pointerImage;   //The pointer to be moved along the image path
    UIImageView *coloredImageView;  //The big image appears when the view gets loaded
    UIImageView *backgroundImageView; //Background image of the view
    UIImageView *writableAreaBackgroundImageView; //Background Image at bottom, where user will write
    UIImageView *writableAreaImageView; //ImageView where user will write in actually
    
    UIImageView *exerciseMainImageView;
    
    CAShapeLayer *myLayer;
    
    
    
    NSString *saveToPhotoAlbum; //String to ensure whether user has checked to save the images to photo gallery or not
    
    
    UIView *settingsView; //Settings view, where the coloroptions will be displayed
    BOOL whetherSettingsViewActive; //To know when user has cliecked the settings view so that drawing will be disabled in the lower view
    
    
    
    NSInteger *abc;
    
    
    //////////////////////////----------SKETCHING VARIBALES---------
   
    UIView *colorPalleteView;
    
    CGPoint lastPoint;
    UIView *canvas;
    UIImageView *drawImage;
    BOOL mouseSwiped;	
    int mouseMoved;
    
    int tapCount;
    
    
    
    ////////////////////////////////////-----------COLOR PALLETE VARIABLES----
    
    CGFloat redColorValue;
    CGFloat greenColorValue;
    CGFloat blueColorValue;
    CGFloat yellowColorValue;
    CGFloat blackColorValue;
    
    int moon_animation_counter;
    int hangontree_animation_counter;
    int greekmask_counter;
    
    
    BOOL moon_Clicked; //For moon ex
    BOOL HangontreeClicked; //For hang on tree ex
    BOOL greekmaskClicked; // For Greek Mask- to check the delegate process for path tracking
    
    UIButton *muteButton;
    
    
}

@property (strong, nonatomic) NSString *sketchImage;
@property (strong, nonatomic) NSString *audioFile;
@property (strong, nonatomic) NSString *coloredImageString;
@property (strong, nonatomic) NSString *exerciseMainImageString;
@property (strong, nonatomic) NSString *exerciseTracingString;
@property (strong, nonatomic) NSString *mainAudioFile;

@property (assign, nonatomic) int exerciseSelected;

@property (strong, nonatomic) UIView *canvas;
@property (strong, nonatomic) UIView *drawImage;


//IBActions & Methods
-(IBAction)backButtonClicked:(id)sender;

- (void)fadeOutLargeImage;
- (void)movePonterToLocation;
- (void)movePointerForTheMoon:(int)animationid;
- (void)cancelButtonClicked;
- (IBAction)colorSelected:(id)sender;
-(IBAction)muteButtonClicked:(id)sender;


-(void)wishingstarPattern;
-(void)beautifuldayPattern;
-(void)birdishflightPattern;
-(void)boxturtlePattern;
-(void)bunnyearPattern;
-(void)snowballPattern;
-(void)flagPattern;

-(void)TopOfTheWorldClicked;
-(void)HangingOnTreeClicked;
-(void)CatEarClicked;
-(void)GreekMaskClicked;
-(void)egyptioanClicked;
-(void)DancingdollsClikced;
-(void)curlyheadClicked;
-(void)crowningKingClicked;

@end
