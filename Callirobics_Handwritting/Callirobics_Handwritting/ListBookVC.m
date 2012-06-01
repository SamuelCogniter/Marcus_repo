//
//  ListBookVC.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListBookVC.h"
#import "ListExercisesVC.h"

@implementation ListBookVC

//Synthesise Book1 Array
@synthesize  exerciseNameArray,exerciseMainImageArray,exerciseSketchImageArray,exerciseAudioArray,whehtherFreeArray, exerciseColoredImageArray,books_images_array, exerciseMainAudioArray;

//Synthesize book2 Array
@synthesize exerciseNameArray2,exerciseMainImageArray2,exerciseSketchImageArray2,exerciseAudioArray2,whehtherFreeArray2, exerciseColoredImageArray2, exerciseMainAudioArray2;

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
    
    
    //Hide the navigation bar
    self.navigationController.navigationBarHidden = YES;
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UserNameExists"] == nil)
    {
        
        
    }
    
    books_images_array = [[NSMutableArray alloc] init];
    [books_images_array addObject:@"book2"];
    [books_images_array addObject:@"book1"];
    
    [[NSUserDefaults standardUserDefaults] setObject:books_images_array forKey:@"bookarray"];
    
    [book1_button setImage:[UIImage imageNamed:[books_images_array objectAtIndex:0]] forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setObject:[books_images_array objectAtIndex:0] forKey:@"Book1"];
    
    [book2_button setImage:[UIImage imageNamed:[books_images_array objectAtIndex:1]] forState:UIControlStateNormal];
    
    
    
    //Initialize the arrays, to strore the books 1  content
    self.exerciseMainImageArray = [[NSMutableArray alloc] init];
    self.exerciseSketchImageArray = [[NSMutableArray alloc] init];
    self.exerciseAudioArray = [[NSMutableArray alloc] init];
    self.whehtherFreeArray = [[NSMutableArray alloc] init];
    self.exerciseNameArray = [[NSMutableArray alloc] init];
    self.exerciseColoredImageArray = [[NSMutableArray alloc] init];
    self.exerciseMainAudioArray = [[NSMutableArray alloc] init];
    
     //Initialize the arrays, to strore the books 2 content
    self.exerciseMainImageArray2 = [[NSMutableArray alloc] init];
    self.exerciseSketchImageArray2 = [[NSMutableArray alloc] init];
    self.exerciseAudioArray2 = [[NSMutableArray alloc] init];
    self.whehtherFreeArray2 = [[NSMutableArray alloc] init];
    self.exerciseNameArray2 = [[NSMutableArray alloc] init];
    self.exerciseColoredImageArray2 = [[NSMutableArray alloc] init];
    self.exerciseMainAudioArray2 = [[NSMutableArray alloc] init];
    
    
    
    
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
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];    
    
    if (!temp)
    {
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    }
    
    
    NSLog(@"Dict is %@", temp);
    
    
    //Save the root node of the plist into a dictionary
    booksDict =[[NSMutableDictionary alloc]init];
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
        
    
    NSString *exMainImageString;
    NSString *exColoredImageString; //This the 1st image to be loaded on ExerciseVC
    NSString *exSketchImageString;
    NSString *exAudio;
    NSString *freeOrPaidString;
    NSString *exerciseNameString;
    NSString *exerciseMainAudioString;


    //If exercises available, then parse the objects and keys
    if ([tempArr count] > 0)
    {
        for (NSMutableDictionary *helloDict in tempArr)
        {
            
            exerciseNameString = [helloDict objectForKey:@"ExerciseName"];
            [exerciseNameArray addObject:exerciseNameString];
            
            exColoredImageString = [helloDict objectForKey:@"ExerciseColoredImage"];
            [exerciseColoredImageArray addObject:exColoredImageString];
            
            
            exMainImageString = [helloDict objectForKey:@"ExerciseMainImage"];
            [exerciseMainImageArray addObject:exMainImageString];
            
            exSketchImageString= [helloDict objectForKey:@"ExerciseSketchImage"];
            [exerciseSketchImageArray addObject:exSketchImageString];
            
            exAudio= [helloDict objectForKey:@"ExerciseAudio"];
            [exerciseAudioArray addObject:exAudio];
            
            exerciseMainAudioString = [helloDict objectForKey:@"ExerciseMainAudio"];
            [exerciseMainAudioArray addObject:exerciseMainAudioString];
            
            freeOrPaidString = [helloDict objectForKey:@"Free"];
            [whehtherFreeArray addObject:freeOrPaidString];
            
   
        }
    }
    
    NSLog(@"Main image array is %@",exerciseMainImageArray);
    NSLog(@"Skecth image array is %@",exerciseSketchImageArray);
    NSLog(@"Audio  array is %@",exerciseAudioArray);
    NSLog(@"free or not array is %@",whehtherFreeArray);
    NSLog(@"exercise name array is %@",exerciseNameArray);
    NSLog(@"Exercise colored image array is %@",exerciseColoredImageArray);
    NSLog(@"Exercise Main Audio array is %@",exerciseMainAudioArray);
    
    
    
    //FETCH THE BOOK 2 CONTENTS 
    
    NSMutableDictionary *book2_dic5 =[[NSMutableDictionary alloc]init];
    book2_dic5 = [booksDict objectForKey:@"Book2"];
    NSLog(@"book 2 array is %@",book2_dic5);
    
    
    //Parse the exercises in book 1
    NSMutableArray *tempArr_book2 = [[NSMutableArray alloc] init];
    for (NSMutableArray *myArr2 in book2_dic5)
    {
        [tempArr_book2 addObject:myArr2];
    }
    
    
    NSString *exMainImageString2;
    NSString *exColoredImageString2; //This the 1st image to be loaded on ExerciseVC
    NSString *exSketchImageString2;
    NSString *exAudio2;
    NSString *freeOrPaidString2;
    NSString *exerciseNameString2;
    NSString *exerciseMainAudioString2;
    
    
    //If exercises available, then parse the objects and keys
    if ([tempArr_book2 count] > 0)
    {
        for (NSMutableDictionary *helloDict2 in tempArr_book2)
        {
            
            exerciseNameString2 = [helloDict2 objectForKey:@"ExerciseName"];
            [exerciseNameArray2 addObject:exerciseNameString2];
            
            exColoredImageString2 = [helloDict2 objectForKey:@"ExerciseColoredImage"];
            [exerciseColoredImageArray2 addObject:exColoredImageString2];
            
            
            exMainImageString2 = [helloDict2 objectForKey:@"ExerciseMainImage"];
            [exerciseMainImageArray2 addObject:exMainImageString2];
            
            exSketchImageString2 = [helloDict2 objectForKey:@"ExerciseSketchImage"];
            [exerciseSketchImageArray2 addObject:exSketchImageString2];
            
            exAudio2= [helloDict2 objectForKey:@"ExerciseAudio"];
            [exerciseAudioArray2 addObject:exAudio2];
            
            exerciseMainAudioString2 = [helloDict2 objectForKey:@"ExerciseMainAudio"];
            [exerciseMainAudioArray2 addObject:exerciseMainAudioString2];
            
            freeOrPaidString2 = [helloDict2 objectForKey:@"Free"];
            [whehtherFreeArray2 addObject:freeOrPaidString2];
            
        }
    }
    
    NSLog(@"Main image array 2 is %@",exerciseMainImageArray2);
    NSLog(@"Skecth image array 2 is %@",exerciseSketchImageArray2);
    NSLog(@"Audio  array 2  is %@",exerciseAudioArray2);
    NSLog(@"free or not array 2 is %@",whehtherFreeArray2);
    NSLog(@"exercise name array 2 is %@",exerciseNameArray2);
    NSLog(@"Exercise colored image array 2 is %@",exerciseColoredImageArray2);
    NSLog(@"Exercise Main Audio array 2 is %@",exerciseMainAudioArray2);

}

#pragma mark - Action Methods
- (IBAction)booksButtonClicked:(id)sender
{
    
    ListExercisesVC *vc = [[ListExercisesVC alloc] initWithNibName:@"ListExercisesVC" bundle:nil];
    vc.exercisesDictForBook = [booksDict objectForKey:[NSString stringWithFormat:@"Book%d",[sender tag]]];
    
    vc.plistPath = plistPath;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",[sender tag]] forKey:@"bookno"];
    
    // To save user selected book like book_1 in database
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"BOOK_%d",[sender tag]] forKey:@"BookSelected"];
    
    //[[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"book1"];
    
    
    //For Book 1
    if([sender tag] ==1)
    {
     //   ListExercisesVC *vc = [[ListExercisesVC alloc] initWithNibName:@"ListExercisesVC" bundle:nil];
        
        vc.exerciseListNameArray = self.exerciseNameArray;                  //Pass the exercises name
        vc.exerciseListMainImageArray = self.exerciseMainImageArray;        //Pass the main image name
        vc.exerciseSketchListImageArray = self.exerciseSketchImageArray;    //Pass the writable image name
        vc.exerciseAudioListArray = self.exerciseAudioArray;                //Pass the intro audio file name
        vc.exerciseMainAudioArray = self.exerciseMainAudioArray;            //Pass the main audio array
        vc.numberOfExercises = [self.exerciseNameArray count];              //Count of exercises in a book
        vc.exerciseColoredImageArray = self.exerciseColoredImageArray;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    //For Book 2
    else if ([sender tag] == 2)
    {
        //ListExercisesVC *vc = [[ListExercisesVC alloc] initWithNibName:@"ListExercisesVC" bundle:nil];
        
        vc.exerciseListNameArray = self.exerciseNameArray2;                 //Pass the exercises name
        vc.exerciseListMainImageArray = self.exerciseMainImageArray2;       //Pass the main image name
        vc.exerciseSketchListImageArray = self.exerciseSketchImageArray2;   //Pass the writable image name
        vc.exerciseAudioListArray = self.exerciseAudioArray2;               //Pass the intro audio file name
        vc.exerciseMainAudioArray = self.exerciseMainAudioArray2;           //Pass the main audio array
        vc.numberOfExercises2 = [self.exerciseNameArray2 count];             //Count of exercises in a book
        vc.exerciseColoredImageArray = self.exerciseColoredImageArray2;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (IBAction)backButtonClicked:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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


#pragma mark - Orientation Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
