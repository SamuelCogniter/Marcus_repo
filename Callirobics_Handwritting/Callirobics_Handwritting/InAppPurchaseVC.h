//
//  InAppPurchaseVC.h
//  Callirobics_Handwritting
//
//  Created by Harpreet Rupal on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InAppPurchaseVC : UIViewController
{
    NSString *exerciseSelected;
}

@property (strong, nonatomic) NSString *exerciseSelected;


- (void)cancelButtonClicked;
- (void)fetchBookDetails;

@end
