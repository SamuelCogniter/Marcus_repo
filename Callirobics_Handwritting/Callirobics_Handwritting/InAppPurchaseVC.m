//
//  InAppPurchaseVC.m
//  Callirobics_Handwritting
//
//  Created by Harpreet Rupal on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InAppPurchaseVC.h"

@implementation InAppPurchaseVC

@synthesize exerciseSelected;

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
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonClicked)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    NSLog(@"ex is %@",exerciseSelected);
    
    [self fetchBookDetails];
}


#pragma mark - Other methods

- (void)cancelButtonClicked
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
}

- (void)fetchBookDetails
{
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
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"bookno"] != nil)
    {
    
    NSMutableDictionary *dic5 =[[NSMutableDictionary alloc]init];

    dic5 = [booksDict objectForKey:[NSString stringWithFormat:@"Book%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"bookno"]]];       
    NSLog(@"book %@ array is %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"bookno"],dic5);
    
    
    //Parse the exercises in book 1
    NSMutableArray *exercisesArray = [[NSMutableArray alloc] init];
    for (NSMutableArray *myArr in dic5)
    {
        [exercisesArray addObject:myArr];
    }
        NSLog(@"Exercise array is %@",exercisesArray);
    
        NSString *exerciseNameString;
        NSString *exerciseColoredImageString;
        NSString *exerciseMainImageString;
        NSString *exerciseSkecthImageString;
        NSString *exerciseAudioString;
        NSString *exerciseMainAudioString;
        NSString *booksPaidOrFreeString;
        
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
}


#pragma mark - Memory management methods

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
