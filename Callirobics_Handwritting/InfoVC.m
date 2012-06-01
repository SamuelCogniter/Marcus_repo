//
//  InfoVC.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InfoVC.h"

@implementation InfoVC

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
    
    //Create Custom Loading view
    //Set corners and frame to loading indicator view
   
    [self.view addSubview:m_LoadingView];
    
    NSURLRequest *requestObj;
    NSString *URLStr = @"http://www.callirobics.com";
    
    
    
    requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:URLStr]];
    
    
    //Load the request in the UIWebView.
    [callirobicsWebView loadRequest:requestObj];
    
    //scale the page to the device - This can also be done in IB if you prefer
    callirobicsWebView.scalesPageToFit = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear
{
    self.navigationController.navigationBarHidden = YES;

    if ([callirobicsWebView isLoading])
        [callirobicsWebView stopLoading];
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
	
	[m_LoadingView removeFromSuperview];
}


- (void)viewDidUnload
{
    [callirobicsWebView setDelegate:nil];

    self.navigationController.navigationBarHidden = YES;

    
    
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
