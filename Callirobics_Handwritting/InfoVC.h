//
//  InfoVC.h
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface InfoVC : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *callirobicsWebView;
    
    IBOutlet UIView *m_LoadingView;
    
    NSString *URLString;
}

@end
