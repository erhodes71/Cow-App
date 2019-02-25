//
//  mainViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 8/15/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "mainViewController.h"
#import "mainTableViewCell.h"
#import "EditCowViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController
{
    
    
    NSMutableArray* data;
    
    UIViewController* signInViewController;
    UIViewController* manageCowViewController;
    
    //Used for when sending requests
    int hold;
    
    bool doesTokenWork;
    
    //This is used for when the request is sent
    NSString* requestType;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Round the corners of the buttons
    _actionButton.layer.cornerRadius = 5.0;
    _accountButton.layer.cornerRadius = 5.0;
    _manageHerdButton.layer.cornerRadius = 5.0;
    _expensesButton.layer.cornerRadius = 5.0;
    
    
    //Clears current cow ID
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setObject:@"" forKey:@"CURRENT_COW_ID"];
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    
    [self checkCredentials];
    
    doesTokenWork = false;
    
}

- (void)reInitializeView
{
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    
    [self checkCredentials];
    
    doesTokenWork = false;
}

//This method is used to check if the user is on the device
-(void)checkCredentials
{

    //Load
    //  Username
    //  Password
    //  Token
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* password = [prefs stringForKey:@"password"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    //userName = @"erhodes71";
    //token = @"1234";
    //Save data
    /*[prefs setObject:userName forKey:@"userID"];
    [prefs setObject:password forKey:@"password"];
    [prefs setObject:token forKey:@"token"];*/
    
    [self checkIfTokenWorks:userName withToken:token];
    
    NSLog(@"This is the username: %@", userName);
    if([userName isEqualToString:@""])
    {
        //Needs to sign into account
        //Send to login view
        [self changeViewSignIn];
        
    }else{
        //Check token
        
        
        [self sendPost:userName withToken:token];
        
        
        if(doesTokenWork)
        {
            //Continue to main View
        }else{
            //Get new token by logging in
            //Continue to main View
            
        }
        
        
        
    }
    
    
    
    //Check if username exists
        //If it does
            //then try and log in and retrieve the token
            //then have it Initialsize View
        //Else
            //Send them to the account sign-in view
}


-(void) checkIfTokenWorks:(NSString*)username withToken:(NSString*)token
{
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"username=%@&token=%@",username,token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/checkIfTokenWorks.php?username=%@&token=%@",username,token]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}


//Send post
-(void)sendPost:(NSString*)username withToken:(NSString*)token
{
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"username=%@&token=%@",username,token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/test.php?username=%@&token=%@",username,token]]];

    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];

    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}

// This method is used to receive the data which we get using post method.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData*)data
{
    //Converts the data
    NSString *someString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSLog(@"Test %@",someString);
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

//This will take you to the manage herd page
-(void)changeViewManageCow
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    manageCowViewController = [storyboard instantiateViewControllerWithIdentifier:@"ManageCowsViewController"];
    [self addChildViewController:manageCowViewController];
    [self.view addSubview:manageCowViewController.view];
    
    
    
}


//This will take you to the account managment page
-(void)changeViewAccount
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    signInViewController = [storyboard instantiateViewControllerWithIdentifier:@"AccountViewController"];
    [self addChildViewController:signInViewController];
    [self.view addSubview:signInViewController.view];
}



-(void)changeViewSignIn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    signInViewController = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    [self addChildViewController:signInViewController];
    [self.view addSubview:signInViewController.view];
}


-(void)InitializeView
{
    //Loads the table view full of information on the recent activity on the account.
    //Loads the total number of cows
    //Loads the cost per month
    
}


//If the account button is pressed
- (IBAction)accountButtonPressed:(id)sender {
    
    //Changes to the account view
    [self changeViewAccount];
}

//Action button is pressed
// Note, at the moment, this just clears the user data
- (IBAction)actionButtonPressed:(id)sender {
    //NSLog(@"Test");
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
   
    
    //Save data
    /*[prefs setObject:@"" forKey:@"userID"];
    [prefs setObject:@"" forKey:@"password"];
     [prefs setObject:@"" forKey:@"accessToken"];*/
    
    
    NSString* token = [prefs stringForKey:@"accessToken"];
    NSLog(@"TOKEN: %@", token);
    
    
}

//Manage herd button is pressed
- (IBAction)manageHerdButtonPressed:(id)sender {
    [self changeViewManageCow];
}


//Expenses button is pressed
- (IBAction)expensesButtonPressed:(id)sender {
    
}



//If that cell is selected
//Needs to be able to take it to a window
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    //NSLog(@"%@", currentIndex);
    
    //This is how to access parent view controller!
    //This is used to get rid of the buttons while working with the view
    //[(RootViewController*)self.parentViewController hideButtons_side1];
    
    //Sets the current index
    //self->currentIndex = (int)indexPath.row;
    
    
    
    
    //Changes the view
    /*UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ExternalContent_Location_1" bundle:nil];
    
    extraViewController = [storyboard instantiateViewControllerWithIdentifier:@"CampaignPageViewController"];
    [self addChildViewController:extraViewController];
    [self.view addSubview:extraViewController.view];
    */
    
    //
    /*RootViewController *v = (RootViewController*)self.view.superclass;
     [v sendToOtherViewController];*/
    
    
    
    
    
    
    
}


//Gets the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 3;
}




//Adds the cell based on the data
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"mainTableViewCell";
    
    mainTableViewCell *cell = (mainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"mainTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    //cell.testlable.text = @"Test";
    //cell.weight.text = [weightData objectAtIndex:indexPath.row];
    
    //cell.title.text = [titleData objectAtIndex:indexPath.row];
   
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    // This is just Programatic method you can also do that by xib !
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
