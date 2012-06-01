//
//  UsersGroupVC.m
//  Callirobics_Handwritting
//
//  Created by Rishi Ghosh Roy on 4/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UsersGroupVC.h"
#import "HomeVC.h"


#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]



@implementation UsersGroupVC

@synthesize usersNameTableView;

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
    
    
    //Hide the navigation Bar
    self.navigationController.navigationBarHidden = YES;
  
    
    
    //By default user is not in editing mode
    isEditMode = NO;
    
    
    
    
    //Get the AppDelegate reference to fetch the UserName array to be load on the tableView from DataBase
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *query = @"SELECT * FROM USERS";
    [appDelegate fetchUsersDetailsFromDB:query];
    
    
    
    
    
    
    //Initialize the data source array with the database users
    if ([appDelegate.userNameArray count] > 0)
    {
        usersNameArray = [[NSMutableArray alloc] initWithArray:appDelegate.userNameArray];
        [usersNameArray addObject:@"<Create A New User>"];
        
    }
    else 
    {
        usersNameArray = [[NSMutableArray alloc] init];
        [usersNameArray addObject:@"<Create A New User>"];
    }
    
    
    
    
    //Initialize the user's id array
    if ([appDelegate.userIdArray count] > 0)
    {
        usersIdArray = [[NSMutableArray alloc] initWithArray:appDelegate.userIdArray];
        
    }
    else
    {
        usersIdArray = [[NSMutableArray alloc] init];
        
    }
    NSLog(@"User id array is %@",usersIdArray);
    

    
      
}


#pragma mark - IBActions & Other Methods

-(IBAction)backbuttonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)deleteButtonClicked:(id)sender
{
    self.usersNameTableView.editing = TRUE;
    
    isEditMode = YES;
    
    [self.usersNameTableView reloadData];
}

- (IBAction)renameButtonClicked:(id)sender
{
//   [usersNameTableView setBackgroundColor:[UIColor colorWithRed:250 green:200 blue:254 alpha:1.0]];
    [usersNameTableView setBackgroundColor:[UIColor  cyanColor]];
                                             
    self.usersNameTableView.editing = TRUE;
    
    editbutton.hidden=YES;
    confirmbutton.hidden=NO;
    
    isEditMode = YES;
    
    [self.usersNameTableView reloadData];
    
}

- (IBAction)okButtonClicked:(id)sender
{
    
    [usersNameTableView setBackgroundColor:[UIColor whiteColor]];
    
    self.usersNameTableView.editing = FALSE;
    
    confirmbutton.hidden=YES;
    editbutton.hidden=NO;
    
    isEditMode = FALSE;
    
    
    [self.usersNameTableView reloadData];
    
}

- (IBAction)editingButtonCalled:(id)sender
{
    NSLog(@"Row index is %d",rowIndex);
    
    
    //Get reference of tableView cell and get the text on the tableView cell
    UITableViewCell *cell = [usersNameTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    UITextField *usersNameTextField = (UITextField*)[cell viewWithTag:100];
    
    
    
    ////////////////////////If user is not in editting mode///////////////////////////////////
    if (isEditMode == NO) 
    {
        //If Array is full and user is clicked on the <Create A New User> row , then prompt no other user can be added 
        if ([usersNameArray count] == 5 && [sender tag] == 1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"You cannot add more than four users to use this application" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        else 
        {
            //User has clicked on Create a user,pop up the alertview
            if ([sender tag] == 1 && [usersNameArray count] <5)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add User" message:@"\n\n\n\n" delegate:self cancelButtonTitle:@"Add" otherButtonTitles:@"Cancel", nil];
                //alertView.frame = CGRectMake(0, 0, 200, 200);
                CGRect frame = CGRectMake(14, 100, 255, 30);		
                userNameTextField = [[UITextField alloc] initWithFrame:frame];
                userNameTextField.placeholder = @"Name";		
                userNameTextField.backgroundColor = [UIColor whiteColor];		
                userNameTextField.autocorrectionType = UITextAutocorrectionTypeDefault; 		
                userNameTextField.keyboardType = UIKeyboardTypeAlphabet; 		
                userNameTextField.returnKeyType = UIReturnKeyDone;		
                userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing; // has 'x' button to the right	
                [alertView addSubview:userNameTextField];	
                [alertView show];	
            }
            else //Push to the home view with selected users name
            {
                HomeVC *vc = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
                vc.nameString = [usersNameArray objectAtIndex:rowIndex];
                vc.userID =[usersIdArray objectAtIndex:rowIndex];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            
        }
        
    }
    //////////////////////////User is in editting mode///////////////////////////////
    else   
    {
        
        //If its the last row "Crate a new user" then 
        if (rowIndex == [usersNameArray count] -1)
        {
            //NO action needed here
        }
        
        
    }
    
}


#pragma mark - TableView DataSource & Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [usersNameArray count];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isEditMode == YES) //If user is in editting mode
    {
        
        if (indexPath.row == [usersNameArray count] -1)
        {
            
            return UITableViewCellEditingStyleNone;
            
        }
        else
        {
            return UITableViewCellEditingStyleDelete;

        }
        
    }
    else 
        return UITableViewCellEditingStyleNone;
                
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell == nil) 
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	}
    
	for (UIView *tempView in cell.contentView.subviews)
		[tempView removeFromSuperview];
	
    
    //Initialize the labels, that will show the users present in the user defaults array
    UITextField *usersTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 5, 400, 60)];
    usersTextField.backgroundColor = [UIColor clearColor];
    usersTextField.textAlignment = UITextAlignmentCenter;
    usersTextField.font = [UIFont boldSystemFontOfSize:32];
    usersTextField.delegate = self;
    usersTextField.text = [usersNameArray objectAtIndex:indexPath.row];
    usersTextField.tag = indexPath.row;
    
    if (isEditMode == NO)
    {
        usersTextField.enabled = FALSE;
    }
    else 
    {
        usersTextField.enabled = TRUE;
    }
    
    [cell.contentView addSubview:usersTextField];
    
    
    
    //I am adding a button on last index of tableView so that textField beneath this button will not be clicked when user is in editing mode, it will stop the delegate of the textfield.
    if (indexPath.row == [usersNameArray count] -1)
    {
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        editButton.backgroundColor = [UIColor clearColor];
        editButton.frame = CGRectMake(0, 0, 1024, 65);
        editButton.tag = 1;
        [editButton addTarget:self action:@selector(editingButtonCalled:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:editButton];
        
    }
    
    
    
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    rowIndex = indexPath.row;
    
    //User is not in editting mode, push him/her to the welcome view
    if (isEditMode == NO)
    {
        
       
        //Remove the previously stored user defaults value before inserting new values
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserNameExists"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SelectedUser_ID"];

        
        
        //Save the selected user name and id in user defaults for further access in home view
        [[NSUserDefaults standardUserDefaults] setObject:[usersNameArray objectAtIndex:indexPath.row] forKey:@"UserNameExists"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[usersIdArray objectAtIndex:indexPath.row] forKey:@"SelectedUser_ID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
     
        
        
    
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [appDelegate delete_User:[usersIdArray objectAtIndex:indexPath.row]];
        
        if (appDelegate.dbQueryStatus == YES) //No error
        {
        
        [usersNameArray removeObjectAtIndex:indexPath.row];
        }
        
    }
    
    //Save the user names to user defaults for future use
    [[NSUserDefaults standardUserDefaults] setObject:usersNameArray forKey:@"UsersName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.usersNameTableView reloadData];
}






#pragma mark - UIAlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (![allTrim( userNameTextField.text) length] == 0 )
        {
                        
            
            //Save the user names to user defaults for future use
            [[NSUserDefaults standardUserDefaults] setObject:usersNameArray forKey:@"UsersName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            
            //Get the count of books from plist
            NSString *booksValue = [[NSUserDefaults standardUserDefaults] objectForKey:@"BOOKS_COUNT"];

            
            //Add parameter value at run time based upon the books present in plist
            NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
            
            
            //Based upon the counts of the books, generate default values for the books
            for (int i=0; i<[booksValue intValue]; i++)
            {
               

                [valuesArray addObject:@"\"0\""];
            }
            NSLog(@"Values paramerter is %@",valuesArray);
            
            
            NSMutableString *booksParameterString = [[NSMutableString alloc] init];
            for (NSMutableString *tempStr in valuesArray)
            {
                
                [booksParameterString appendFormat:[NSString stringWithFormat:@"%@,",tempStr]];
            }

            
            
            //It will remove the last comma from the string and dynamic parameter for the books is created now
          NSString  *finalBooksParameterStr = [booksParameterString substringToIndex:[booksParameterString length]-1];

            NSLog(@"Final books are %@",finalBooksParameterStr);

            [finalBooksParameterStr stringByReplacingOccurrencesOfString:@"\"\"" withString:@"\""];
            
            NSLog(@"FinaLLLLLLLLLLL books are %@",finalBooksParameterStr);

            
            
            
            
            //Get the books present in plist, so to insert the default values in local db for a user
            NSString *tempBooks = [[NSUserDefaults standardUserDefaults] objectForKey:@"plist_BOOKS"];
            
            NSString *books = [tempBooks stringByReplacingOccurrencesOfString:@"TEXT" withString:@""];
           // NSLog(@"Books is %@",books);
            
    
            
            
            
            /////////////// INSERT USERS INTO DATABASE WITH DEFAULT VALUES 1ST TIME ///////////
            
            if ([books length] > 0)
            {
            
            
            // Get the documents directory
            dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            docsDir = [dirPaths objectAtIndex:0];
            
            // Build the path to the database file
           NSString  *dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"USERS.sqlite"]];
            
            
            const char *dbpath = [dbPath UTF8String];
                
                sqlite3_stmt    *statement;
            
            if (sqlite3_open(dbpath, &usersDB) == SQLITE_OK)
            {
                //INSERT USER QUERY - We have created the user and set the column names for the DB based upon the book presnt into the plist, also set the default color of the background and save images to photo album at here
                
                NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO USERS (USER_NAME, BACKGROUND_SETTINGS_COLOR, SAVE_PHOTO_ALBUM,%@) VALUES(\"%@\", \"%@\", \"%@\",%@)", books,userNameTextField.text, @"1", @"0",finalBooksParameterStr];
                
                NSLog(@"Query is %@",insertSQL);

                
                const char *insert_stmt = [insertSQL UTF8String];
                
                sqlite3_prepare_v2(usersDB, insert_stmt, -1, &statement, NULL);
                if (sqlite3_step(statement) == SQLITE_DONE)
                {
                    NSLog(@"User added in database with default settings");
                    
                    
                    NSString *query = @"SELECT * FROM USERS";
                    [appDelegate fetchUsersDetailsFromDB:query]; 
                    
                    
                    //Initialize the data source array with the database users
                    if ([appDelegate.userNameArray count] > 0)
                    {
                        usersNameArray = [[NSMutableArray alloc] initWithArray:appDelegate.userNameArray];
                        [usersNameArray addObject:@"<Create A New User>"];
                        
                    }
                    else 
                    {
                        usersNameArray = [[NSMutableArray alloc] init];
                        [usersNameArray addObject:@"<Create A New User>"];
                    }
                    
                    
                    
                    
                    //Initialize the user's id array
                    if ([appDelegate.userIdArray count] > 0)
                    {
                        usersIdArray = [[NSMutableArray alloc] initWithArray:appDelegate.userIdArray];
                        
                    }
                    else
                    {
                        usersIdArray = [[NSMutableArray alloc] init];
                        
                    }
                    
                    
                    //[usersNameArray insertObject:userNameTextField.text atIndex:[usersNameArray count] -1];

                    self.usersNameTableView.editing = FALSE;
                    
                    isEditMode = FALSE;
                    
                    [usersNameTableView reloadData];

                } 
                else 
                {
                    NSLog(@"Contact not added");
                }
                sqlite3_finalize(statement);
                sqlite3_close(usersDB);
            }

            }
        }
    }
    else 
    {
        [userNameTextField resignFirstResponder];
    }
}


#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGRect frame=self.view.frame;
    frame.origin.x=0;
    frame.origin.y=0;
    self.view.frame=frame;
    [UIView commitAnimations];	
    
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    /*[UIView beginAnimations:nil context:nil];
     [UIView setAnimationDuration:0.5];
     CGRect frame=self.usersNameTableView.frame;
     frame.origin.x=self.usersNameTableView.frame.origin.x;
     frame.origin.y=-20;
     self.usersNameTableView.frame=frame;
     [UIView commitAnimations];*/
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    updatedUserName = textField.text;
    userIdForRenameUser = [usersIdArray objectAtIndex:[textField tag]];
    
    
    
    NSLog(@"Updated name is %@ for user id %@",updatedUserName,userIdForRenameUser);
    
    //Update user name
    [appDelegate updateUserName:userIdForRenameUser name:updatedUserName];
    
    if (appDelegate.dbQueryStatus == YES)
    {
        [usersNameArray replaceObjectAtIndex:[textField tag] withObject:updatedUserName];

    }
    
    
    return YES;
    
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
