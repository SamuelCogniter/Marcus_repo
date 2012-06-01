//
//  ListExercisesVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListExercisesVC : UIViewController<UIScrollViewDelegate, UIAlertViewDelegate>
{
    //IBOutlets
    IBOutlet UIScrollView *listExercisesScrollView;
    
    NSMutableArray *Ex_countingarr;
    
    //Define the arrays to be used FOR BOOK 1
    NSMutableArray *exerciseListNameArray;
    NSMutableArray *exerciseListMainImageArray;
    NSMutableArray *exerciseColoredImageArray;
    NSMutableArray *exerciseSketchListImageArray;
    NSMutableArray *exerciseAudioListArray;     //Intro Audio file Array
    NSMutableArray *exerciseMainAudioArray;     //Main Audio file Array
    NSMutableArray *whehtherFreeListArray;
    
    //Define the arrays to be used FOR BOOK 2
//    NSMutableArray *exerciseListNameArray2;
//    NSMutableArray *exerciseListMainImageArray2;
//    NSMutableArray *exerciseColoredImageArray2;
//    NSMutableArray *exerciseSketchListImageArray2;
//    NSMutableArray *exerciseAudioListArray2;     //Intro Audio file Array
//    NSMutableArray *exerciseMainAudioArray2;     //Main Audio file Array
//    NSMutableArray *whehtherFreeListArray2;

    
    IBOutlet UIImageView *bookimage;
    
    
    
    int numberOfExercises;  //Calculate the number of exercise present in a book and generate buttons dynamically
   int numberOfExercises2;
    
    NSMutableDictionary *exercisesDictForBook; //This dict will hold all the exercises for selected book
    NSString *plistPath;

    NSMutableArray *free_Paid_Array; //This array will hold wheather the ex is paid or free based on value stored in plist
    
    NSString *exSelected;
    
}

@property (nonatomic, strong) NSMutableDictionary *exercisesDictForBook;
@property (nonatomic, strong) NSString *plistPath;


@property (nonatomic, strong) IBOutlet UIImageView *bookimage;

@property (nonatomic, strong) NSMutableArray *exerciseListNameArray;
@property (nonatomic, strong) NSMutableArray *exerciseListMainImageArray;
@property (nonatomic, strong) NSMutableArray *exerciseSketchListImageArray;
@property (nonatomic, strong) NSMutableArray *exerciseAudioListArray;
@property (nonatomic, strong) NSMutableArray *whehtherFreeListArray;
@property (nonatomic, strong) NSMutableArray *exerciseColoredImageArray;
@property (nonatomic, strong) NSMutableArray *exerciseMainAudioArray;



//@property (nonatomic, strong) NSMutableArray *exerciseListNameArray2;
//@property (nonatomic, strong) NSMutableArray *exerciseListMainImageArray2;
//@property (nonatomic, strong) NSMutableArray *exerciseSketchListImageArray2;
//@property (nonatomic, strong) NSMutableArray *exerciseAudioListArray2;
//@property (nonatomic, strong) NSMutableArray *whehtherFreeListArray2;
//@property (nonatomic, strong) NSMutableArray *exerciseColoredImageArray2;
//@property (nonatomic, strong) NSMutableArray *exerciseMainAudioArray2;

@property (nonatomic, assign) int numberOfExercises;
@property (nonatomic, assign) int numberOfExercises2;

//IBActions & Methods
- (IBAction)backButtonClicked:(id)sender;
- (void)loadImages;

@end
