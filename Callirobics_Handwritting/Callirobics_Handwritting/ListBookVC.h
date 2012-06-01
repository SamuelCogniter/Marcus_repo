//
//  ListBookVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListBookVC : UIViewController
{
    
    //Define the arrays to be used for Book 1
    NSMutableArray *exerciseNameArray;          //NAME OF THE EXERCISE
    NSMutableArray *exerciseColoredImageArray;  //1ST IMAGE TO BE SHOWN
    NSMutableArray *exerciseMainImageArray;     //MAIN IMAGE-WHERE PATH WILL BE FOLLOWED
    NSMutableArray *exerciseSketchImageArray;   //SKETCHABLE AREA IMAGE - WHERE USER WILL DRAW
    NSMutableArray *exerciseAudioArray;         // EX. INTRO AUDIO MUSIC FILE
    NSMutableArray *exerciseMainAudioArray;     //EX. MAIN AUDIO FILES TO B PLAYED
    NSMutableArray *whehtherFreeArray;          //EX. IS FREE OR PAID
    
    //Define the arrays to be used for Book 2
    NSMutableArray *exerciseNameArray2;          //NAME OF THE EXERCISE
    NSMutableArray *exerciseColoredImageArray2;  //1ST IMAGE TO BE SHOWN
    NSMutableArray *exerciseMainImageArray2;     //MAIN IMAGE-WHERE PATH WILL BE FOLLOWED
    NSMutableArray *exerciseSketchImageArray2;   //SKETCHABLE AREA IMAGE - WHERE USER WILL DRAW
    NSMutableArray *exerciseAudioArray2;         // EX. INTRO AUDIO MUSIC FILE
    NSMutableArray *exerciseMainAudioArray2;     //EX. MAIN AUDIO FILES TO B PLAYED
    NSMutableArray *whehtherFreeArray2;          //EX. IS FREE OR PAID
    
    
    NSMutableArray *books_images_array;     //Book buttons images array
    
    IBOutlet UIButton *book1_button;        // Outlets for book buttons 
    IBOutlet UIButton *book2_button;
    IBOutlet UIButton *book3_button;
    IBOutlet UIButton *book4_button;
    IBOutlet UIButton *book5_button;
    
   
    
    NSString *bookSelected; //Check user has clicked on which book, so that we can save the exercises on DB based upon this book selected
    
    
    NSMutableDictionary *booksDict; //Save all the books in this dictionary at first
    NSString *plistPath;
    
    
}

@property (nonatomic,strong) NSMutableArray *books_images_array;

//Property for book1 Array
@property (nonatomic,strong) NSMutableArray *exerciseNameArray;
@property (nonatomic, strong) NSMutableArray *exerciseColoredImageArray;
@property (nonatomic,strong) NSMutableArray *exerciseMainImageArray;
@property (nonatomic,strong) NSMutableArray *exerciseSketchImageArray;
@property (nonatomic,strong) NSMutableArray *exerciseAudioArray;
@property (nonatomic, strong) NSMutableArray *exerciseMainAudioArray;
@property (nonatomic,strong) NSMutableArray *whehtherFreeArray;

//Property for book2 Arrays
@property (nonatomic,strong) NSMutableArray *exerciseNameArray2;
@property (nonatomic, strong) NSMutableArray *exerciseColoredImageArray2;
@property (nonatomic,strong) NSMutableArray *exerciseMainImageArray2;
@property (nonatomic,strong) NSMutableArray *exerciseSketchImageArray2;
@property (nonatomic,strong) NSMutableArray *exerciseAudioArray2;
@property (nonatomic, strong) NSMutableArray *exerciseMainAudioArray2;
@property (nonatomic,strong) NSMutableArray *whehtherFreeArray2;

//IBActions & Methods

- (IBAction)booksButtonClicked:(id)sender;

- (IBAction)backButtonClicked:(id)sender;

@end
