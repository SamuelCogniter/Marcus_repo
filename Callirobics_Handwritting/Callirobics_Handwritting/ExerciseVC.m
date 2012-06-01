//
//  Created by Rishi Ghosh Roy on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExerciseVC.h"
#import "HomeVC.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"


#define P(x,y) CGPointMake(x, y)
static int k =0;

@implementation ExerciseVC


@synthesize audioFile,sketchImage,coloredImageString, exerciseMainImageString;
@synthesize exerciseTracingString, exerciseSelected, mainAudioFile, canvas, drawImage;


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
    
    moon_Clicked = NO;
    HangontreeClicked=NO;
    greekmaskClicked=NO;
    
    moon_animation_counter = 0;
    hangontree_animation_counter=0;
    greekmask_counter=0;
    
    //ADD THE BACKGROUND IMAGEVIEW AT HERE
    backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BG-Blue.png"]];
    [self.view addSubview:backgroundImageView];
    
    
    
    
    
    //THE BIG COLORED IMAGE WILL APPEAR AT FIRST, SO ADD IT OVER HERE TO ITS PARENT VIEW
    //Add the colored d imageview at here, the colored image will appear at first
    NSLog(@"%@",coloredImageString );
    
    
    coloredImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:coloredImageString]];
    coloredImageView.frame = CGRectMake(200, 0, 576, 768);
    coloredImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:coloredImageView];
    
    
    
    
    
    
    
    //Fetch the settings from user defaults and set the writableImage area background color
    NSMutableDictionary *userSettingsDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserSettings"]];
    
    NSString *writableAreaBackground = [userSettingsDict objectForKey:@"WritingAreaBackgroundColor"];
    saveToPhotoAlbum = [userSettingsDict objectForKey:@"SaveToPhotoAlbum"];
    
    
    
    
    
    
    //Writable area image view
    writableAreaBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    if (writableAreaBackground != nil && [writableAreaBackground length] > 0)
    {
        
        writableAreaBackgroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"writingBG%@",writableAreaBackground]];
    }
    else 
    {
        writableAreaBackgroundImageView.image = [UIImage imageNamed:@"writingBG1.png"];
    }
    
    
    
    
    
    
    //Initialize and play the intro audio music file only if intro music file is available
    if (audioFile != nil && [audioFile length] > 0)
    {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",audioFile] ofType:@"mp3"]] error:nil];
        //player.numberOfLoops = 1;
        player.delegate = self;
        
        player.volume = 1.0;
        [player play];
    }
    
    
    
    
    
    //Fade out and remove the colored image from its parent view 
    [self performSelector:@selector(fadeOutLargeImage) withObject:nil afterDelay:1.0];
    
    
    
    
    
    
    //User has not clicked to the settings button yet, make it default as NO
    whetherSettingsViewActive = NO;
    
    
    
    
    //Default value of RGB. - color will be drawn BLACK
    redColorValue = 0.0;
    blueColorValue = 0.0;
    greenColorValue = 0.0;
    
}

-(void)muteButtonClicked
{
    
    if(k%2==0)
    {
        
        [mainAudioPlayer stop];
        [muteButton setBackgroundImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [mainAudioPlayer play];
        [muteButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    }
    k++;
    
}


#pragma mark - IBActions & Other Methods

//********************************************** Book 1 Start ********************************************************

//Excercise 1 - The Boat Race
- (void)movePonterToLocation
{
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 8.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-169, pointerImage.frame.origin.y-24);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -69, pointerImage.frame.origin.y-204);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +37, pointerImage.frame.origin.y-24);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +144, pointerImage.frame.origin.y-204);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +247, pointerImage.frame.origin.y-24);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +356, pointerImage.frame.origin.y-204);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +451, pointerImage.frame.origin.y-24);
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 11.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 8.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}

//Excercise 2 - Done
- (void)movePointerForTheMoon:(int)animationid
{
    moon_Clicked =YES;
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.1f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();    
    
    if(moon_animation_counter ==0)
    {
        CGPathAddArc(pointPath, NULL, 438.5, 202, 85, -M_PI_2+0.67 , M_PI_2-0.67, YES);
    }
    else if (moon_animation_counter ==1)
    {
        CGPathAddArc(pointPath, NULL, 648, 202, 85, -M_PI_2+0.67 , M_PI_2-0.67, YES);
    }
    else if (moon_animation_counter ==2)
    {
        CGPathAddArc(pointPath, NULL, 868, 202, 85, -M_PI_2+0.67 , M_PI_2-0.67, YES);
    }
    
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 12.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
     
    
}

//Excercise 3 - DONE
-(void)DowntownPattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 9.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-91, pointerImage.frame.origin.y-22);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x-91, pointerImage.frame.origin.y-189);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +56, pointerImage.frame.origin.y-189);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +56, pointerImage.frame.origin.y-36);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +203, pointerImage.frame.origin.y-36);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +203, pointerImage.frame.origin.y-189);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +349, pointerImage.frame.origin.y-189);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +349, pointerImage.frame.origin.y-22);
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 13.0;
    myLayer.fillColor = nil;
    
    myLayer.lineJoin = kCALineJoinBevel;
    
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 9.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}

//Excercise 4
-(void)conductorPattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.1f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();    
    
    
    CGPathAddArc(pointPath, NULL, 588, 198, 90, -M_PI_4-2.2 , M_PI_4-1.9, YES);
    CGPathAddArc(pointPath, NULL, 688, 198, 92, -M_PI_4-1.8 , M_PI_4-0.9, YES);
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 14.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}


//Excercise 5 - Wishing Star - DONE
-(void)wishingstarPattern
{
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 10.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+30, pointerImage.frame.origin.y-113);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 230, pointerImage.frame.origin.y-113);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-113);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-200);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-22);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-113);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 219, pointerImage.frame.origin.y-198);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-113);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 38, pointerImage.frame.origin.y-24);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-113);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 42, pointerImage.frame.origin.y-198);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 130, pointerImage.frame.origin.y-113);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 222, pointerImage.frame.origin.y-24);
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 12.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 10.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}
//Excercise 6 - Beautiful Day - Only Circle is done, lines pending
-(void)beautifuldayPattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 11.1f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable(); 
    
    
    
    //Draw Complete Circle
    CGPathAddArc(pointPath, NULL, 635, 205, 89, -M_PI_2-0.8 , M_PI_2-3.90, YES);  //Complete Circle
    
    //Draw Initial Line 
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+72, pointerImage.frame.origin.y-175);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 12, pointerImage.frame.origin.y-235);
    
    //Draw second Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+47, pointerImage.frame.origin.y-111.5);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+10 , pointerImage.frame.origin.y-111.5);
    
    //Third Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+63, pointerImage.frame.origin.y-50);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+12 , pointerImage.frame.origin.y);
    
    //Fourth Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+130, pointerImage.frame.origin.y-32);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+130 , pointerImage.frame.origin.y+8);
    
    //Fifth Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+197, pointerImage.frame.origin.y-50);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+248 , pointerImage.frame.origin.y+2);
    
    //Sixth Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+212, pointerImage.frame.origin.y-111.5);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+250 , pointerImage.frame.origin.y-111.5);
    
    //Seventh Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+195, pointerImage.frame.origin.y-181);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+248 , pointerImage.frame.origin.y-234);
    
    //Eighth Line
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+130, pointerImage.frame.origin.y-200);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+130 , pointerImage.frame.origin.y-230);
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 12.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 11.1; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}

//Excercise 7
-(void)birdishflightPattern
{
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    //    CGPathAddArc(pointPath, NULL, 674, 316, 77, -M_PI-0.1, M_PI/2-1.5, NO);
    //    CGPathAddArc(pointPath, NULL, 825, 316, 77, -M_PI, M_PI/2-1.5, NO);
    
    UIBezierPath *trackPath = [UIBezierPath bezierPath];
	[trackPath moveToPoint:P(418, 296)];
    
	[trackPath addCurveToPoint:P(636, 296)
				 controlPoint1:P(470,-19)
				 controlPoint2:P(645, 145)];
	[trackPath addCurveToPoint:P(850 ,296)
				 controlPoint1:P(688, -45)
				 controlPoint2:P(874, 190)];
    
    pathAnimation.path = trackPath.CGPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path =  trackPath.CGPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 14.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
    
    
    
}

//Excercise 08 -  Turtle - DONE
-(void)boxturtlePattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-80, pointerImage.frame.origin.y-31);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 33, pointerImage.frame.origin.y-31);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 33, pointerImage.frame.origin.y-192);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 210, pointerImage.frame.origin.y-192);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 210, pointerImage.frame.origin.y-31);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 320, pointerImage.frame.origin.y-31);
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 13.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}

//Excercise 9 bunny ear
-(void)bunnyearPattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.1f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef path;
//    CGPoint point;
//    CGPoint controlPoint1;
//    CGPoint controlPoint2;
//    
    path = CGPathCreateMutable();
    
    
//    point = CGPointMake(528.0f, 287.0f);
//    CGPathMoveToPoint(path, NULL, point.x, point.y);
//    
//    point = CGPointMake(560.0, 240.5f);
//    controlPoint1 = CGPointMake(690.5f,240.5f);
//    controlPoint2 = CGPointMake(538.5f, -45.5f);
//    CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
//    
//    point = CGPointMake(685.5f, 120.5f);
//    
//    controlPoint1 = CGPointMake(670.5f, 370.5f);
//    controlPoint2 = CGPointMake(750.5f, 180);
//    CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
//    
//    point = CGPointMake(750.5f, 287.5f);
//    controlPoint1 = CGPointMake(608.5f, 310.5f);
//    controlPoint2 = CGPointMake(715.5f, 270.5f);
//    CGPathAddCurveToPoint(path, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, point.x, point.y);
//    
        CGPathAddArc(path, NULL, 528, 197, 89, -M_PI-1.3 , M_PI-2.5, YES);
    
        //CGPathAddArc(path, NULL, 628, 197, 100, -M_PI-2.6 , M_PI-1.0, YES);
    
    
//    CGPathAddArc(path, NULL, 635, 198, 89, -M_PI_2-2.2 , M_PI_2-0.8, YES);  //Complete Circle

//    CGPathAddArc(path, NULL, 737, 197, 89, -M_PI/2-2.1 , M_PI/2, YES);
    
    pathAnimation.path = path;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = path;
    // myLayer.path = path2.CGPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 13.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(path);
    
}

//Excercise 10 - Snow ball
-(void)snowballPattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 9.1f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();    
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+142, pointerImage.frame.origin.y-228);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+85 , pointerImage.frame.origin.y-193);
    
    CGPathAddArc(pointPath, NULL, 631, 202, 84, -M_PI_2-0.8 , M_PI_2-1.6, YES);
    
    CGPathAddArc(pointPath, NULL, 639, 204, 75, -M_PI_2+1.2, M_PI_2+1.4, YES);
        
    CGPathAddArc(pointPath, NULL, 630, 202, 68, -M_PI_2-1.9 , M_PI_2-2.1, YES);
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 11.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 9.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}

//Excercise - 11 - Flag - DONE
-(void)flagPattern
{
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 60, 60);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+43, pointerImage.frame.origin.y-177);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 43, pointerImage.frame.origin.y-20);
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+41, pointerImage.frame.origin.y-174);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 280, pointerImage.frame.origin.y-174);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 280, pointerImage.frame.origin.y-59);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x + 41, pointerImage.frame.origin.y-59);
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 11.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);
    
}



//********************************************** Book 1 End  ********************************************************


- (void)fadeOutLargeImage
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:3.0];
    [coloredImageView setAlpha:0];
    [UIView commitAnimations];
}


//Pop view
- (void)cancelButtonClicked
{
    //Excercise ID
    NSString *string_Excercise_ID = [NSString stringWithFormat:@"%d",exerciseSelected];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate update_ExcerciseStatus:[[NSUserDefaults standardUserDefaults]objectForKey:@"SelectedUSERID"] 
                                Bookname:[[NSUserDefaults standardUserDefaults] objectForKey:@"BookSelected"]
                                ExcerciseID:string_Excercise_ID];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


//Save image to iPad Photo Gallery
- (void)saveButtonClicked
{
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}


- (IBAction)colorSelected:(id)sender
{
    
    if ([sender tag] == 1)      //Red color selected
    {
        redColorValue = 1.0;
        blueColorValue = 0.0;
        greenColorValue = 0.0;
        
    }
    else if ([sender tag] == 2) //Green color selected
    {
        redColorValue = 0.0;
        blueColorValue = 0.0;
        greenColorValue = 1.0;
        
    }
    else if ([sender tag] == 3) //Blue color selected
    {
        redColorValue = 0.0;
        blueColorValue = 1.0;
        greenColorValue = 0.0;
    }
    else if ([sender tag] == 4) //Yellow color selected
    {
        redColorValue = 135.0;
        blueColorValue = 0.0;
        greenColorValue = 213.0;
    }
    else    //Black color selected
    {
        redColorValue = 0.0;
        blueColorValue = 0.0;
        greenColorValue = 0.0;
    }
    
}




#pragma mark - Save Image To Photo Album Delegate

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                           message:@"Unable to save image to Photo Album." 
                                          delegate:nil cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    else 
        alert = [[UIAlertView alloc] initWithTitle:@"Success" 
                                           message:@"Image saved to Photo Album." 
                                          delegate:nil cancelButtonTitle:@"Ok" 
                                 otherButtonTitles:nil];
    [alert show];
}


#pragma mark - CAKeyFrame Animation Delegate Method


//This delegate is called after the completion of Animation.
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    
    //Remove the 1st colored imageView after animation gets over
    [coloredImageView removeFromSuperview];
    
    
    
    //After the colored image will dis-appear this image will appear so that our pointer can trace the paths.
    NSLog(@"MAIN IMAGE STR IS %@",exerciseMainImageString);
    exerciseMainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:exerciseMainImageString]];
    [backgroundImageView addSubview:exerciseMainImageView];
    
    
    
    
    //Add the cancel button to its parent view as a subview
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor clearColor];
    cancelButton.frame = CGRectMake(975, 6, 40, 40);
    cancelButton.showsTouchWhenHighlighted = YES;
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"Cancel.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    NSString *bookno = [[NSUserDefaults standardUserDefaults] objectForKey:@"bookno"];
    
    int bno = [bookno intValue];
    
    if(bno ==1)
    {
        //Move the pointer to show the path
        if (exerciseSelected == 1)   //This will draw the path for "The Boat" exercise
        {
            //Excercise 1 - triangles
            [self movePonterToLocation];
        }
        else if (exerciseSelected == 2) //This will draw the path for "The Moon" exercise
        {
            //Excercise 2 - moon
            [self movePointerForTheMoon:moon_animation_counter];
        }
        else if (exerciseSelected == 3)
        {
            //Excercise 3 - Downltown
            [self DowntownPattern];
        }
        else if (exerciseSelected == 4)
        {
            //Excercise 4 - conductor
            [self conductorPattern];
        }
        else if (exerciseSelected == 5)
        {
            //Excercise 5 - Wishing Star
            [self wishingstarPattern];
        }
        else if (exerciseSelected == 6)
        {
            //Excercise 6 - Beautiful Day
            [self beautifuldayPattern];
        }
        else if (exerciseSelected == 7)
        {
            //Excercise 7 - Birdish
            [self birdishflightPattern];
        }
        else if (exerciseSelected == 8)
        {
            //Excercise 8 - turtle
            [self boxturtlePattern];
        }
        else if (exerciseSelected == 9)
        {
            //Excercise 9 - Bunny ear
            [self bunnyearPattern];
        }
        else if (exerciseSelected == 10)
        {
            //Excercise 10 - snow ball
            [self snowballPattern];
        }
        else if (exerciseSelected == 11)
        {
            //Excercise 11 - Flag
            [self flagPattern];
        }

    }
    //Excercises for book 2
    else if (bno ==2)
    {
        if (exerciseSelected == 1)
        {
            [self TopOfTheWorldClicked];
                 
        }
        else if (exerciseSelected == 2)
        {
            [self HangingOnTreeClicked];
        }
        else if (exerciseSelected == 3)
        {
            [self CatEarClicked];
        }
        else if (exerciseSelected == 4)
        {
            [self GreekMaskClicked];
        }
        else if (exerciseSelected ==5)
        {
            [self egyptioanClicked];
        }
        else if (exerciseSelected ==6)
        {
            [self DancingdollsClikced];
        }
        else if (exerciseSelected ==7)
        {
            [self curlyheadClicked];
        }
        else if (exerciseSelected ==8)
        {
            [self crowningKingClicked];
        }
             
        
    }
    
}

//********************************************** Book 2 Start ********************************************************
-(void)TopOfTheWorldClicked
{
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 30, 30);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 12.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
 
    //First Half
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-74, pointerImage.frame.origin.y+10);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -63, pointerImage.frame.origin.y-20);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -57, pointerImage.frame.origin.y-10);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -40, pointerImage.frame.origin.y-54);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -34, pointerImage.frame.origin.y-44);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -19, pointerImage.frame.origin.y-84);

    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x, pointerImage.frame.origin.y+12);
    
    //Second half
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+11, pointerImage.frame.origin.y-19);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+17, pointerImage.frame.origin.y-7);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+38, pointerImage.frame.origin.y-58);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+44, pointerImage.frame.origin.y-43);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+64, pointerImage.frame.origin.y-82);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+80, pointerImage.frame.origin.y+12);
    
    //Third half
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+91, pointerImage.frame.origin.y-19);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+97, pointerImage.frame.origin.y-6);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+117, pointerImage.frame.origin.y-55);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+121, pointerImage.frame.origin.y-43);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+138, pointerImage.frame.origin.y-80);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+150, pointerImage.frame.origin.y+13);
    
    //Fourth half
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+160, pointerImage.frame.origin.y-20);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+167, pointerImage.frame.origin.y-7);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+189, pointerImage.frame.origin.y-55);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+194, pointerImage.frame.origin.y-43);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+210, pointerImage.frame.origin.y-80);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+222, pointerImage.frame.origin.y+14);
    
    //Fifth half
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+240, pointerImage.frame.origin.y-20);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+246, pointerImage.frame.origin.y-7);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+269, pointerImage.frame.origin.y-55);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+272, pointerImage.frame.origin.y-44);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+288, pointerImage.frame.origin.y-79);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+298, pointerImage.frame.origin.y+15);
    
    //Six half
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+314, pointerImage.frame.origin.y-16);

    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+318, pointerImage.frame.origin.y-7);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+336, pointerImage.frame.origin.y-55);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+340, pointerImage.frame.origin.y-44);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+354, pointerImage.frame.origin.y-77);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+368, pointerImage.frame.origin.y+16);
    
    //Seventh half
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+383, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+387, pointerImage.frame.origin.y-5);
   
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+407, pointerImage.frame.origin.y-53);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+412, pointerImage.frame.origin.y-41);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+430, pointerImage.frame.origin.y-78);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+442, pointerImage.frame.origin.y+16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+460, pointerImage.frame.origin.y-12);
    
    
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor redColor] CGColor];
    myLayer.lineWidth = 5.0;
    
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 12.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);

}

-(void)HangingOnTreeClicked
{
    HangontreeClicked=YES;
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 30, 30);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 6.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    //First Half
    if(hangontree_animation_counter == 0)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-3 , pointerImage.frame.origin.y-35);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x-3 , pointerImage.frame.origin.y-80);
        
        CGPathAddArc(pointPath, NULL, 517, 240, 14.5, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+26 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+26 , pointerImage.frame.origin.y-35);
    }
    else if (hangontree_animation_counter ==1)
    {
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+49 , pointerImage.frame.origin.y-35);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+49 , pointerImage.frame.origin.y-80);
        
        CGPathAddArc(pointPath, NULL, 568, 240, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+78 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+78 , pointerImage.frame.origin.y-37);
        
        CGPathAddArc(pointPath, NULL, 598, 240, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+106 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+106 , pointerImage.frame.origin.y-37);

        
    }
    else if (hangontree_animation_counter ==2)
    {
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+126 , pointerImage.frame.origin.y-37);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+126 , pointerImage.frame.origin.y-80);
        
        CGPathAddArc(pointPath, NULL, 644, 240, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+155 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+155 , pointerImage.frame.origin.y-37);
        
        CGPathAddArc(pointPath, NULL, 674, 240, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+184 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+184 , pointerImage.frame.origin.y-37);

        CGPathAddArc(pointPath, NULL, 704, 240, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+213 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+213 , pointerImage.frame.origin.y-37);
        
    }
    else if (hangontree_animation_counter ==3)
    {
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+238, pointerImage.frame.origin.y-39);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+238 , pointerImage.frame.origin.y-80);
        
        CGPathAddArc(pointPath, NULL, 757, 240, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);

        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+264, pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+264 , pointerImage.frame.origin.y-39);
        
        CGPathAddArc(pointPath, NULL, 784, 237, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+292, pointerImage.frame.origin.y-84);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+292 , pointerImage.frame.origin.y-39);
        
        CGPathAddArc(pointPath, NULL, 811, 236, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+320, pointerImage.frame.origin.y-84);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+320 , pointerImage.frame.origin.y-39);
        
        CGPathAddArc(pointPath, NULL, 840, 236, 14, -M_PI_2-1.5, M_PI_2-1.7, NO);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+348, pointerImage.frame.origin.y-84);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+348 , pointerImage.frame.origin.y-39);
        
        
    }
    else if (hangontree_animation_counter == 4)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-4 , pointerImage.frame.origin.y+20);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x-4 , pointerImage.frame.origin.y+65);
        
        CGPathAddArc(pointPath, NULL, 515, 381, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+24 , pointerImage.frame.origin.y+65);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+24 , pointerImage.frame.origin.y+20);
    }
    else if (hangontree_animation_counter == 5)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+48 , pointerImage.frame.origin.y+20);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+48 , pointerImage.frame.origin.y+65);
                
        CGPathAddArc(pointPath, NULL, 565, 380, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+74 , pointerImage.frame.origin.y+65);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+74 , pointerImage.frame.origin.y+20);
        
        CGPathAddArc(pointPath, NULL, 593, 379, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+101 , pointerImage.frame.origin.y+65);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+101 , pointerImage.frame.origin.y+20);

        
    }
    
    else if (hangontree_animation_counter == 6)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+125 , pointerImage.frame.origin.y+20);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+125 , pointerImage.frame.origin.y+65);
        
        CGPathAddArc(pointPath, NULL, 643, 378, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+151 , pointerImage.frame.origin.y+65);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+151 , pointerImage.frame.origin.y+20);
        
        CGPathAddArc(pointPath, NULL, 669, 378, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+180 , pointerImage.frame.origin.y+65);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+180 , pointerImage.frame.origin.y+20);
        
        CGPathAddArc(pointPath, NULL, 697, 378, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);  
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+207 , pointerImage.frame.origin.y+65);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+207 , pointerImage.frame.origin.y+20);
        
        
    }

    else if (hangontree_animation_counter == 7)
    {
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+233 , pointerImage.frame.origin.y+20);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+233 , pointerImage.frame.origin.y+60);
        
        CGPathAddArc(pointPath, NULL, 753, 376, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+260 , pointerImage.frame.origin.y+62);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+260 , pointerImage.frame.origin.y+17);

        
        CGPathAddArc(pointPath, NULL, 780, 376, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+290 , pointerImage.frame.origin.y+62);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+290 , pointerImage.frame.origin.y+16);

        
        CGPathAddArc(pointPath, NULL, 807, 375, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+318 , pointerImage.frame.origin.y+60);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+318 , pointerImage.frame.origin.y+16);

        
        CGPathAddArc(pointPath, NULL, 834, 374, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
        
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+344 , pointerImage.frame.origin.y+60);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+344 , pointerImage.frame.origin.y+16);

        HangontreeClicked = NO;
    }
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor redColor] CGColor];
    myLayer.lineWidth = 5.0;
    
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 6.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);

    
}

-(void)CatEarClicked
{
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 30, 30);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 8.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-50, pointerImage.frame.origin.y-37);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x -24, pointerImage.frame.origin.y-83);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x-2, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +25, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +45, pointerImage.frame.origin.y+6);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +68, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +90, pointerImage.frame.origin.y-37);
        
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +118, pointerImage.frame.origin.y-83);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +140, pointerImage.frame.origin.y-37);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +163, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +184, pointerImage.frame.origin.y+7);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +206, pointerImage.frame.origin.y-37);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +230, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +255, pointerImage.frame.origin.y-83);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +280, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +304, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +326, pointerImage.frame.origin.y+7);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +350, pointerImage.frame.origin.y-37);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +370, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +394, pointerImage.frame.origin.y-83);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +418, pointerImage.frame.origin.y-37);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +442, pointerImage.frame.origin.y-37);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +466, pointerImage.frame.origin.y+7);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x +490, pointerImage.frame.origin.y-37);
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 5.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 8.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);

    
}

-(void)GreekMaskClicked
{
    greekmaskClicked = YES;
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 30, 30);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 8.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    //***************First face *************************
    if(greekmask_counter ==0)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+76 , pointerImage.frame.origin.y-80);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+76 , pointerImage.frame.origin.y-46);
        CGPathAddArc(pointPath, NULL, 603, 269, 22, -M_PI_2-1.7, M_PI_2-1.5, YES);
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+122 , pointerImage.frame.origin.y-46);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+122 , pointerImage.frame.origin.y-80);
    }
    else if (greekmask_counter ==1)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+90, pointerImage.frame.origin.y-67);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+90 , pointerImage.frame.origin.y-62);
    }
    else if (greekmask_counter ==2)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+110, pointerImage.frame.origin.y-67);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+110 , pointerImage.frame.origin.y-62);
    }
    else if (greekmask_counter ==3)
    {
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+100, pointerImage.frame.origin.y-53);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+100 , pointerImage.frame.origin.y-48);
    }
    else if (greekmask_counter ==4)
    {
        CGPathAddArc(pointPath, NULL, 604, 273, 10, -M_PI_2-1.7, M_PI_2-1.5, YES);
    }
    //*****************Second face **************************
    
    else if (greekmask_counter ==5)
    {
        CGPathAddArc(pointPath, NULL, 648, 273, 19, -M_PI_2-1.7, M_PI_2-1.5, YES);
        CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+163 , pointerImage.frame.origin.y-42);
        CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+163 , pointerImage.frame.origin.y-80);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//    CGPathAddArc(pointPath, NULL, 593, 379, 14, -M_PI_2-2.1, M_PI_2-1.5, YES);
//    
//    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+101 , pointerImage.frame.origin.y+65);
//    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+101 , pointerImage.frame.origin.y+20);
    
    
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor blueColor] CGColor];
    myLayer.lineWidth = 5.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 8.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);

    
    
}

-(void)egyptioanClicked
{
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 30, 30);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 8.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x+15, pointerImage.frame.origin.y-16);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+62, pointerImage.frame.origin.y-109);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+87, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+109, pointerImage.frame.origin.y-61);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+127, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+149, pointerImage.frame.origin.y-61);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+170, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+219, pointerImage.frame.origin.y-109);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+244, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+266, pointerImage.frame.origin.y-61);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+283, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+307, pointerImage.frame.origin.y-61);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+323, pointerImage.frame.origin.y-16);

    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+372, pointerImage.frame.origin.y-109);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+397, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+419, pointerImage.frame.origin.y-61);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+441, pointerImage.frame.origin.y-16);
    
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+463, pointerImage.frame.origin.y-61);
    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x+485, pointerImage.frame.origin.y-16);
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 5.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 8.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);

}

-(void)DancingdollsClikced
{
    
    
    
    
    
}


-(void)curlyheadClicked
{
    
    
    
    
    
}


-(void)crowningKingClicked
{
    
    
    pointerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pointer.png"]];
    pointerImage.frame = CGRectMake(505, 318, 30, 30);
    [self.view addSubview:pointerImage];
    
    
    //Add key frame animation with multipe path valies
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.duration = 8.0f;
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    
    
    //This code is actually moving the pointer to the path    
    
    CGMutablePathRef pointPath = CGPathCreateMutable();
    
//    CGPathMoveToPoint(pointPath, NULL, pointerImage.frame.origin.x-25, pointerImage.frame.origin.y-54);
//    CGPathAddLineToPoint(pointPath, NULL, pointerImage.frame.origin.x-25, pointerImage.frame.origin.y-100);
    
    CGPathAddArc(pointPath, NULL, 490, 211, 22, -M_PI_2-2.3, M_PI_2-1.2, YES);
    
    
    pathAnimation.path = pointPath;
    
    [pointerImage.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
    
    
    
    //Add the shape layer to the parent view to draw the path
    myLayer = [[CAShapeLayer alloc] init];
    myLayer.path = pointPath;
    myLayer.strokeColor = [[UIColor greenColor] CGColor];
    myLayer.lineWidth = 5.0;
    myLayer.fillColor = nil;
    myLayer.lineJoin = kCALineJoinBevel;
    [backgroundImageView.layer addSublayer:myLayer]; //Add sublayer of colored image view
    
    
    
    
    //Add the basic animation to draw the stroke color of the shape layer
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 8.0; //"animate over 10 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    drawAnimation.removedOnCompletion = NO;   // Remain stroked after the animation..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // Add the animation
    [myLayer addAnimation:drawAnimation forKey:@"drawLayerAnimation"];
    
    
    
    CGPathRelease(pointPath);

    
    
}


//********************************************** Book 2 End ********************************************************

- (void)animationDidStop:(CAAnimation *) animation finished:(bool) flag
{
    //Remove the pointer image from its superview on animation completion
    [pointerImage removeFromSuperview];
    
    
    //Remove all the previos layer animations
    [myLayer removeAllAnimations];
    
    if(moon_Clicked == YES)
    {
        moon_animation_counter++;
    
        if(moon_animation_counter == 1)
        {
            [self movePointerForTheMoon:1];
        }
        else if (moon_animation_counter == 2)
        {
            [self movePointerForTheMoon:2];
            
            moon_Clicked = NO;
        }
            
    }

    if(HangontreeClicked == YES)
    {
        hangontree_animation_counter++;
        if(hangontree_animation_counter == 1)
        {
            [self HangingOnTreeClicked];
        }
        else if (hangontree_animation_counter == 2)
        {
            [self HangingOnTreeClicked];
        }
        else if (hangontree_animation_counter == 3)
        {
            [self HangingOnTreeClicked];
        }
        else if (hangontree_animation_counter == 4)
        {
            [self HangingOnTreeClicked];
        }
        else if (hangontree_animation_counter == 5)
        {
            [self HangingOnTreeClicked];
        }
        else if (hangontree_animation_counter == 6)
        {
            [self HangingOnTreeClicked];
        }
        else if (hangontree_animation_counter == 7)
        {
            [self HangingOnTreeClicked];
        }
        
    }
    
    if(greekmaskClicked ==YES)
    {
        
        greekmask_counter++;
        
        if(greekmask_counter == 1)
        {
            [self GreekMaskClicked];
        }
        else if (greekmask_counter == 2)
        {
            [self GreekMaskClicked];
        }
        else if (greekmask_counter == 3)
        {
            [self GreekMaskClicked];
        }
        else if (greekmask_counter == 4)
        {
            [self GreekMaskClicked];
        }
        else if (greekmask_counter == 5)
        {
            [self GreekMaskClicked];
        }
        else if (greekmask_counter == 6)
        {
            [self GreekMaskClicked];
        }
        else if (greekmask_counter == 7)
        {
            [self GreekMaskClicked];
        }
    }
    
    //Add the writing area image view to its parent view after path drawn is finished
    writableAreaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    writableAreaImageView.backgroundColor = [UIColor clearColor];
    writableAreaImageView.image = [UIImage imageNamed:exerciseTracingString];
    [writableAreaBackgroundImageView addSubview:writableAreaImageView];
    [backgroundImageView addSubview:writableAreaBackgroundImageView];

    
    //Add the Save button to its parent view as a subview
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.backgroundColor = [UIColor clearColor];
    saveButton.frame = CGRectMake(670, 665, 180, 60);
    saveButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    saveButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"SaveScreenShot.png"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    
    //Add the Save button to its parent view as a subview
    muteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    muteButton.backgroundColor = [UIColor clearColor];
    muteButton.frame = CGRectMake(970, 670, 48, 48);

    [muteButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    [muteButton addTarget:self action:@selector(muteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:muteButton];
    
    
    
    //Add the color options button
    UIButton *redColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    redColorButton.backgroundColor = [UIColor clearColor];
    redColorButton.frame = CGRectMake(58, 670, 49, 49);
    redColorButton.showsTouchWhenHighlighted = YES;
    redColorButton.tag = 1;
    [redColorButton setBackgroundImage:[UIImage imageNamed:@"red.png"] forState:UIControlStateNormal];
    [redColorButton addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redColorButton];
    
    
    UIButton *greenColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    greenColorButton.backgroundColor = [UIColor clearColor];
    greenColorButton.frame = CGRectMake(127, 670, 49, 49);
    greenColorButton.showsTouchWhenHighlighted = YES;
    greenColorButton.tag = 2;
    [greenColorButton setBackgroundImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
    [greenColorButton addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:greenColorButton];
    
    
    
    UIButton *blueColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blueColorButton.backgroundColor = [UIColor clearColor];
    blueColorButton.frame = CGRectMake(197, 670, 49, 49);
    blueColorButton.showsTouchWhenHighlighted = YES;
    blueColorButton.tag = 3;
    [blueColorButton setBackgroundImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
    [blueColorButton addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueColorButton];
    
    
    UIButton *yellowColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    yellowColorButton.backgroundColor = [UIColor clearColor];
    yellowColorButton.frame = CGRectMake(267, 670, 49, 49);
    yellowColorButton.showsTouchWhenHighlighted = YES;
    yellowColorButton.tag = 4;
    [yellowColorButton setBackgroundImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
    [yellowColorButton addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yellowColorButton];
    
    
    UIButton *blackColorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    blackColorButton.backgroundColor = [UIColor clearColor];
    blackColorButton.frame = CGRectMake(337, 670, 49, 49);
    blackColorButton.showsTouchWhenHighlighted = YES;
    blackColorButton.tag = 5;
    [blackColorButton setBackgroundImage:[UIImage imageNamed:@"black.png"] forState:UIControlStateNormal];
    [blackColorButton addTarget:self action:@selector(colorSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blackColorButton];
    

    
    
    
    
    
    self.view.frame = self.view.bounds;
    
    self.canvas = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [writableAreaBackgroundImageView addSubview:canvas];
    
    
    
    self.drawImage = [[UIImageView alloc] initWithImage:nil];
    self.drawImage.frame = CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height);
    [canvas addSubview:drawImage];
    
    
    mouseMoved = NO;
    

    

    
    
    //Initialize and play the main audio music file only if main music file is available after the completion of path drawing
    if (mainAudioFile != nil && [mainAudioFile length] > 0)
    {
        mainAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@",mainAudioFile] ofType:@"mp3"]] error:nil];
        mainAudioPlayer.delegate = self;
        mainAudioPlayer.volume = 1.0;
        mainAudioPlayer.numberOfLoops = -1;
        [mainAudioPlayer play];
    }
    
}


#pragma mark - UIToch Delegate Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (whetherSettingsViewActive == NO)
    {
        
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 2) {
        drawImage.image = nil;
        return;
    }
    
    lastPoint = [touch locationInView:self.canvas];
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (whetherSettingsViewActive == NO)
    {
        
    mouseSwiped = YES;
    
    UITouch *touch = [touches anyObject];	
    CGPoint currentPoint = [touch locationInView:self.canvas];
    
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    [drawImage.image drawInRect:CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), redColorValue, greenColorValue, blueColorValue, 1.0);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
    
    mouseMoved++;
    
    if (mouseMoved == 10) {
        mouseMoved = 0;
    }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (whetherSettingsViewActive == NO)
    {
    
    UITouch *touch = [touches anyObject];
    
    if ([touch tapCount] == 2) {
        drawImage.image = nil;
        return;
    }
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.canvas.frame.size);
        [drawImage.image drawInRect:CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), redColorValue, greenColorValue, blueColorValue, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}
}



#pragma mark - View Deallocate Methods

- (void)viewWillDisappear:(BOOL)animated
{
    [player stop];      //Stop the intro audio player
    player = nil;
    
    [mainAudioPlayer stop];
    mainAudioPlayer = nil;
}



#pragma mark - Memory Management Methods

- (void)viewDidUnload
{
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    [player stop];      //Stop the intro audio player
    player = nil;
    
    [mainAudioPlayer stop];
    mainAudioPlayer = nil;
    
    [super viewDidUnload];
    

    
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
