//
//  ListExercisesVC.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListExercisesVC.h"
#import "ExerciseVC.h"
#import "ListBookVC.h"
#import "InAppPurchaseVC.h"

@implementation ListExercisesVC

@synthesize exerciseListNameArray, exerciseListMainImageArray, exerciseSketchListImageArray, exerciseAudioListArray,exerciseMainAudioArray, whehtherFreeListArray, numberOfExercises, exerciseColoredImageArray,bookimage,numberOfExercises2;

@synthesize exercisesDictForBook, plistPath;

//@synthesize exerciseListNameArray2,exerciseListMainImageArray2,exerciseSketchListImageArray2,exerciseAudioListArray2,
//whehtherFreeListArray2,exerciseColoredImageArray2,exerciseMainAudioArray2;;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSLog(@"Exercise dict is %@",exercisesDictForBook);
    
    /*NSString *exerciseNameString;
     NSString *exerciseColoredImageString;
     NSString *exerciseMainImageString;
     NSString *exerciseSkecthImageString;
     NSString *exerciseAudioString;
     NSString *exerciseMainAudioString;
     NSString *booksPaidOrFreeString;
     
     NSMutableArray *exercisesArray = [[NSMutableArray alloc] init];
     
     if (exercisesDictForBook != nil)
     {
     
     for (NSMutableArray *exArray in exercisesDictForBook)
     {
     [exercisesArray addObject:exArray];
     }
     
     if ([exercisesArray count] > 0)
     {
     
     for (NSMutableDictionary *helloDict2 in exercisesArray)
     {
     
     exerciseNameString = [helloDict2 objectForKey:@"ExerciseName"];
     
     exerciseColoredImageString = [helloDict2 objectForKey:@"ExerciseColoredImage"];
     
     
     exerciseMainImageString = [helloDict2 objectForKey:@"ExerciseMainImage"];
     
     exerciseSkecthImageString = [helloDict2 objectForKey:@"ExerciseSketchImage"];
     
     exerciseAudioString= [helloDict2 objectForKey:@"ExerciseAudio"];
     
     exerciseMainAudioString = [helloDict2 objectForKey:@"ExerciseMainAudio"];
     
     booksPaidOrFreeString = [helloDict2 objectForKey:@"Free"];
     
     }
     
     
     }
     }
     
     
     NSMutableArray *plistArray = [[NSMutableArray alloc] init];
     NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] init];
     
     [plistDict setObject:exerciseNameString forKey:@"ExerciseName"];
     [plistDict setObject:exerciseColoredImageString forKey:@"ExerciseColoredImage"];
     [plistDict setObject:exerciseMainImageString forKey:@"ExerciseMainImage"];
     [plistDict setObject:exerciseSkecthImageString forKey:@"ExerciseSketchImage"];
     [plistDict setObject:exerciseAudioString forKey:@"ExerciseAudio"];
     [plistDict setObject:exerciseMainAudioString forKey:@"ExerciseMainAudio"];
     [plistDict setObject:@"NO" forKey:@"Free"];
     
     
     
     
     ////////////////// Fetch the Books contents from plist///////////////////////////////
     
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
     NSMutableDictionary *temp = (NSMutableDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];    
     
     
     if (!temp)
     {
     // NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
     }
     
     
     
     NSLog(@"Dict is %@", temp);
     
     
     
     NSMutableDictionary* booksDict =[[NSMutableDictionary alloc]init];
     booksDict = [temp objectForKey:@"Books"];
     
     
     
     //////////////--------Fetch the Book 1 content-------------/////////////////
     
     NSMutableDictionary *dic5 =[[NSMutableDictionary alloc]init];
     dic5 = [booksDict objectForKey:@"Book1"];
     NSLog(@"book 1 array is %@",dic5);
     
     
     //Parse the exercises in book 1
     NSMutableArray *tempArr = [[NSMutableArray alloc] init];
     for (NSMutableArray *myArr in dic5)
     {
     [tempArr addObject:myArr];
     }
     
     
     
     [tempArr replaceObjectAtIndex:0 withObject:plistDict];
     [temp setObject:tempArr forKey:@"Book1"];
     [temp writeToFile:path atomically:YES];
     
     
     */
    
    
    Ex_countingarr = [[NSMutableArray alloc] init];
    
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0020_1.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0019_2.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0018_3.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0017_4.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0016_5.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0015_6.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0014_7.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0013_8.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0012_9.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0011_10.png" ];
    [Ex_countingarr addObject:@"buttons_0000s_0000s_0010_11.png" ];
    [Ex_countingarr addObject: @"buttons_0000s_0000s_0009_12.png"];
    
    NSMutableArray *books_images_array2 = [[NSMutableArray alloc] init];
    [books_images_array2 addObject:@"book2"];
    [books_images_array2 addObject:@"book1"];
    
    NSString *bookno2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"bookno"];
    
    int bno2 = [bookno2 intValue];
    
    if(bno2 ==1)
    {
        bookimage.image = [UIImage imageNamed:[books_images_array2 objectAtIndex:0]];
    }
    else if (bno2 ==2)
    {
        bookimage.image = [UIImage imageNamed:[books_images_array2 objectAtIndex:1]];
    }
    
    
    
    
    //Hide the navigation bar
    self.navigationController.navigationBarHidden = YES;
    
    
    
    //   //Call this method to generate the buttons dynamically based upon the exercises present in a book  
    //    [self loadImages];
}



-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    
    NSLog(@"Exercise dict is %@",exercisesDictForBook);
    
    free_Paid_Array = [[NSMutableArray alloc] init];
    
    NSString *booksPaidOrFreeString;
    
    NSMutableArray *exercisesArray = [[NSMutableArray alloc] init];
    
    if (exercisesDictForBook != nil)
    {
        
        for (NSMutableArray *exArray in exercisesDictForBook)
        {
            [exercisesArray addObject:exArray];
        }
        
        if ([exercisesArray count] > 0)
        {
            
            for (NSMutableDictionary *helloDict2 in exercisesArray)
            {
                
                booksPaidOrFreeString = [helloDict2 objectForKey:@"Free"];
                
                [free_Paid_Array addObject:booksPaidOrFreeString];
            }
            
            NSLog(@"Free paid array is %@",free_Paid_Array);
        }
    }
    
    
    //Call this method to generate the buttons dynamically based upon the exercises present in a book  
    [self loadImages];
}


#pragma mark - IBActions & Methods

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Generate buttons/exercises dynamically based upon the contents present in array
- (void)loadImages 
{
    NSString *bookno = [[NSUserDefaults standardUserDefaults] objectForKey:@"bookno"];
    
    int bno = [bookno intValue];
    
    if(bno ==1)
    {
        //Set x and y coordinates..
        int xcoord = 150;
        int ycoord = 250;
        
        //Loop for generating buttons according to array loop
        for (int i = 0 ; i < numberOfExercises ; i++)
        {
            if (i%6 == 0 && i!= 0) 
            {		
                //Create next line first element
                ycoord = (95 + 6) * i/6 + 250;
                xcoord =150;
            }
            
            else if (i != 0)
            {		
                //Load next element on same line
                xcoord = xcoord + 115+6;
            }
            
            
            //Add Image button to view
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(xcoord, ycoord, 126, 126);
            
            
            if([free_Paid_Array count] > 0)
            {
                if ([[free_Paid_Array objectAtIndex:i] isEqualToString:@"NO"])
                {
                    [imageButton setBackgroundImage:[UIImage imageNamed:@"LightBUtton_lock.png"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [imageButton setBackgroundImage:[UIImage imageNamed:@"buttons_0000s_0000s_0022_LightBUtton.png"] forState:UIControlStateNormal];
                    
                }
                
                
            }
            
            [imageButton setImage:[UIImage imageNamed:[Ex_countingarr objectAtIndex:i]] forState:UIControlStateNormal];
            
            //[imageButton setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            imageButton.tag = i;
            
            [imageButton addTarget:self action:@selector(exerciseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [listExercisesScrollView addSubview:imageButton];
            
        }
        
        //Set Scroll view content size
        float scrollviewHeight = (numberOfExercises/5*80);
        
        if (numberOfExercises % 5 > 0) 
        {
            scrollviewHeight += 60;
        }
        
        listExercisesScrollView.contentSize = CGSizeMake(1000, scrollviewHeight+100);
    }
    else if (bno ==2)
    {
        //Set x and y coordinates..
        int xcoord = 100;
        int ycoord = 250;
        
        //Loop for generating buttons according to array loop
        for (int i = 0 ; i < numberOfExercises2 ; i++)
        {
            if (i%7 == 0 && i!= 0) 
            {		
                //Create next line first element
                ycoord = (95 + 7) * i/7 + 250;
                xcoord =100;
            }
            else if (i != 0)
            {		
                //Load next element on same line
                xcoord = xcoord + 105+7;
            }
            
            //Add Image button to view
            UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            imageButton.frame = CGRectMake(xcoord, ycoord, 126, 126);
            
            if([free_Paid_Array count] > 0)
            {
                if ([[free_Paid_Array objectAtIndex:i] isEqualToString:@"NO"])
                {
                    [imageButton setBackgroundImage:[UIImage imageNamed:@"LightBUtton_lock.png"] forState:UIControlStateNormal];
                    
                }
                else
                {
                    [imageButton setBackgroundImage:[UIImage imageNamed:@"buttons_0000s_0000s_0022_LightBUtton.png"] forState:UIControlStateNormal];
                    
                }
                
                
            }
            
            [imageButton setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
            imageButton.tag = i;
            
            [imageButton addTarget:self action:@selector(exerciseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [listExercisesScrollView addSubview:imageButton];
            
        }
        
        //Set Scroll view content size
        float scrollviewHeight = (numberOfExercises2/5*80);
        
        if (numberOfExercises2 % 5 > 0) 
        {
            scrollviewHeight += 60;
        }
        
        listExercisesScrollView.contentSize = CGSizeMake(1000, scrollviewHeight+100);
    }
    
}	

//Click on an exercise wil take the user to its detail page
- (void)exerciseButtonClicked:(id)sender
{
    
    if ([[free_Paid_Array objectAtIndex:[sender tag]] isEqualToString:@"NO"])
    {
        exSelected = [NSString stringWithFormat:@"%D",[sender tag]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"To enjoy the feature, please buy this exercise first!" delegate:self cancelButtonTitle:@"Buy" otherButtonTitles:@"No thanks", nil];
        [alert show];
        
    }
    else
    {
        
        ExerciseVC *vc = [[ExerciseVC alloc] initWithNibName:@"ExerciseVC" bundle:nil];
        
        vc.audioFile = [exerciseAudioListArray objectAtIndex:[sender tag]]; //Intro audio file
        vc.mainAudioFile = [exerciseMainAudioArray objectAtIndex:[sender tag]]; //Pass the main audio
        vc.coloredImageString = [exerciseColoredImageArray objectAtIndex:[sender tag]];
        vc.exerciseMainImageString = [exerciseListMainImageArray objectAtIndex:[sender tag]];
        vc.exerciseTracingString = [exerciseSketchListImageArray objectAtIndex:[sender tag]];
        vc.exerciseSelected =  [sender tag]+1;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


#pragma mark - AlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        InAppPurchaseVC *vc = [[InAppPurchaseVC alloc] initWithNibName:@"InAppPurchaseVC" bundle:nil];
        vc.exerciseSelected = exSelected;
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentModalViewController:navC animated:YES];
    }
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
