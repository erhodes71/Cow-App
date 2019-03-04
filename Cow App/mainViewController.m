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
#import "ExpensesViewController.h"

@interface mainViewController ()

@end

@implementation mainViewController
{
    
    
    NSMutableArray* data;
    
    NSMutableArray* typesActivity;
    NSMutableArray* objectsInActivty;
    NSMutableArray* dateActivity;
    
    
    UIViewController* signInViewController;
    UIViewController* manageCowViewController;
    UIViewController* expensesViewController;
    
    //Used for when sending requests
    int hold;
    
    bool doesTokenWork;
    
    //This is used for when the request is sent
    NSString* requestType;
    
    bool currentlyRequestingMainData;
    bool currentlyRequestingRecentData;
    bool currentlyRequestingValidToken;
    
    
    NSString* recievedData;
    
    
    //NSMutableArray* cowNames;
    
    NSString* numberCows;
    NSString* numberOfExpenses;
    NSString* monthlyBudget;
    NSString* totalExpenseCost;
    NSString* surplus;
    
    
    NSString* recentAcivity;
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Round the corners of the buttons
    _actionButton.layer.cornerRadius = 5.0;
    _accountButton.layer.cornerRadius = 5.0;
    _manageHerdButton.layer.cornerRadius = 5.0;
    _expensesButton.layer.cornerRadius = 5.0;
    _tableView.layer.cornerRadius = 5.0;
    
    currentlyRequestingMainData = false;
    currentlyRequestingRecentData = false;
    currentlyRequestingValidToken = false;
    
    
    //Recieved data
    recievedData = @"";
    
    
    //Clears current cow ID
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setObject:@"" forKey:@"CURRENT_COW_ID"];
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    typesActivity = [NSMutableArray arrayWithObjects:nil];
    objectsInActivty = [NSMutableArray arrayWithObjects:nil];
    dateActivity = [NSMutableArray arrayWithObjects:nil];
    
    
    doesTokenWork = false;
    
    //Initialize to blank
    numberCows = @"";
    numberOfExpenses = @"";
    monthlyBudget = @"";
    totalExpenseCost = @"";
    surplus = @"";
    
    [self checkCredentials];
    
}

- (void)reInitializeView
{
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    data = [NSMutableArray arrayWithObjects:nil];
    typesActivity = [NSMutableArray arrayWithObjects:nil];
    objectsInActivty = [NSMutableArray arrayWithObjects:nil];
    dateActivity = [NSMutableArray arrayWithObjects:nil];
    
    
    doesTokenWork = false;
    
    [self checkCredentials];
    
    
}

//This method is used to check if the user is on the device
-(void)checkCredentials
{

    //For return data
    currentlyRequestingValidToken = true;
    
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
    
    //[self getMainData:userName withToken:token];
    
    NSLog(@"This is the username: %@", userName);
    if([userName isEqualToString:@""])
    {
        //Needs to sign into account
        //Send to login view
        [self changeViewSignIn];
        
    }else{
        //Check token
        [self getMainData];
        
        
        
    }
    
    
    
    //Check if username exists
        //If it does
            //then try and log in and retrieve the token
            //then have it Initialsize View
        //Else
            //Send them to the account sign-in view
}

//Sends post request to the get the main data
-(void) getMainData
{
    //TODO: Change the address
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    //NSString* password = [prefs stringForKey:@"password"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"userID=%@&token=%@",userName,token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/getMainData.php"]]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded"
     //@"multipart/form-data"
   forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
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
    [request setValue:@"application/x-www-form-urlencoded"
     //@"multipart/form-data"
   forHTTPHeaderField:@"Content-Type"];
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
    NSString *data_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    recievedData = [NSString stringWithFormat:@"%@%@",recievedData,data_string];
    
   
    //NSLog(@"Test %@",data_string);
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //NSLog(@"Test FAIL");
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if([recievedData isEqualToString:@"401"])
    {
        NSLog(@"TOKEN DOES NOT WORK");
        //Send to login
        [self changeViewSignIn];
    }else{
        //Parse and load data
        recievedData = [recievedData stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSArray *lists = [recievedData componentsSeparatedByString:@":"];
        numberCows = lists[0];
        numberOfExpenses = lists[1];
        monthlyBudget = lists[2];
        totalExpenseCost = lists[3];
        surplus = lists[4];
        
        NSString* expensesString = [lists[5] stringByReplacingOccurrencesOfString:@"}" withString:@""];
        expensesString = [expensesString stringByReplacingOccurrencesOfString:@"{" withString:@""];
        
        NSArray* expeneses = [expensesString componentsSeparatedByString:@";"];
        
        int count = 0;
        for(NSString* s in expeneses)
        {
            NSString* stringElement = s;
            stringElement = [stringElement stringByReplacingOccurrencesOfString:@"]" withString:@""];
            stringElement = [stringElement stringByReplacingOccurrencesOfString:@"[" withString:@""];
            
            
            NSLog(@"VAL: %@", stringElement);
            //Parse each one and load it
            
            
            //[titleData addObject:ii];
            NSArray* stringElemetnObjects = [stringElement componentsSeparatedByString:@","];
            
            for(NSString* ss in stringElemetnObjects)
            {
                if(count == 0)
                {
                    [typesActivity addObject:ss];
                }else if(count == 1)
                {
                    [objectsInActivty addObject:ss];
                }
                else if(count == 2)
                {
                    [dateActivity addObject:ss];
                }
            }
            
            count += 1;
        }
        
        
        
        
        
        typesActivity = [[(NSArray*)typesActivity reverseObjectEnumerator] allObjects];
        objectsInActivty = [[(NSArray*)objectsInActivty reverseObjectEnumerator] allObjects];
        dateActivity = [[(NSArray*)dateActivity reverseObjectEnumerator] allObjects];
        
        [self updateMainData];
        [_tableView reloadData];
    }
}

-(void)updateMainData
{
    _numberOfCowsLable.text = numberCows;
    _numberOfExpensesLable.text = numberOfExpenses;
    
    _monthlyBudgetLable.text = [NSString stringWithFormat:@"$%@",monthlyBudget];
    _totalExpenseCostLable.text = [NSString stringWithFormat:@"$%@",totalExpenseCost];
    _availableSurplusLable.text = [NSString stringWithFormat:@"$%@",surplus];
    
    
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


//
-(void)changeViewExpenses
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    expensesViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExpensesViewController"];
    [self addChildViewController:expensesViewController];
    [self.view addSubview:expensesViewController.view];
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
    [self changeViewExpenses];
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
   
    return [typesActivity count];
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
   
    cell.typeObject.text = [typesActivity objectAtIndex:indexPath.row];
    
    cell.objectAltered.text = [objectsInActivty objectAtIndex:indexPath.row];
    
    cell.dateAltered.text = [dateActivity objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
    // This is just Programatic method you can also do that by xib !
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
