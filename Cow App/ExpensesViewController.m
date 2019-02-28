//
//  ExpensesViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/26/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "ExpensesViewController.h"
#import "ExpensesTableViewCell.h"

@interface ExpensesViewController ()
{
    
    //Data to load in the table
    NSMutableArray* data;
    NSMutableArray* titleData;
    NSMutableArray* descriptionData;
    NSMutableArray* costData;
    NSMutableArray* expenseIdData;
    
    
    UIViewController* addExpenseViewController;
    UIViewController* editExpensesViewController;
    
    NSString* dataReturn;
    
}

@end

@implementation ExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    //Set data to default
    dataReturn = @"";
    
    _AddExpenseButton.layer.cornerRadius = 5.0;
    
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    titleData = [NSMutableArray arrayWithObjects:nil];
    descriptionData = [NSMutableArray arrayWithObjects:nil];
    costData = [NSMutableArray arrayWithObjects:nil];
    expenseIdData = [NSMutableArray arrayWithObjects:nil];


    [self sendRequest];
    
    
    
    //Save the current expense to be used for following view
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:@"" forKey:@"CURRENT_EXP"];

}






//Back Button Pressed
- (IBAction)backButtonPressed:(id)sender {
    
    [self removeSelf];
    
    
}

//Add expense button was pressed
- (IBAction)addExpenseButtonPressed:(id)sender {
    //Go to Cow information page here
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    addExpenseViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddExpenseViewController"];
    [self addChildViewController:addExpenseViewController];
    [self.view addSubview:addExpenseViewController.view];
}


//This will start the edit expense view
- (void)sendToEditExpenseView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    editExpensesViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditExpensesViewController"];
    [self addChildViewController:editExpensesViewController];
    [self.view addSubview:editExpensesViewController.view];
}




//If that cell is selected
//Needs to be able to take it to a window
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%ld", (long)indexPath.row);
    
    NSLog(@"Expense ID: %@", expenseIdData[indexPath.row]);
    
    
    //Sets the expense id
    //Save the current cow to be used for following view
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *expID = expenseIdData[(int)indexPath.row];
    [prefs setObject:expID forKey:@"CURRENT_EXP"];
    
    //Makes edit espense view appear
    [self sendToEditExpenseView];
    
    
    
}


//Gets the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [expenseIdData count];
}




//Adds the cell based on the data
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"ExpensesTableViewCell";
    
    ExpensesTableViewCell *cell = (ExpensesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ExpensesTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
    }
    
    //Note: for date and times, for now we need to stick with - instead of /. Just for now.
    
    cell.titleLable.text = [titleData objectAtIndex:indexPath.row];
    cell.descriptionTextView.text = [descriptionData objectAtIndex:indexPath.row];
    cell.costLable.text = [costData objectAtIndex:indexPath.row];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
    // This is just Programatic method you can also do that by xib !
}






//Removes self from parent
-(void)removeSelf
{
    [self.view setHidden:true];
    [self.view removeFromSuperview];
}




//-----Sending request methods-----

-(void)sendRequest
{
    //Starts the spinner
    //[_spinner setHidden:false];
    //[_spinner startAnimating];
    
    NSString* keys = @"userID=%@&token=%@";
    
    //Load user data
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    //NSString* expID = [prefs stringForKey:@"CURRENT_EXP"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:keys,userName,token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/getListOfExpenses.php"]]];
    
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
    NSString *data_return = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",data_return);
    
    dataReturn = [NSString stringWithFormat:@"%@%@",dataReturn,data_return];
    
    //Stops the spinner from spinning
    //[_spinner setHidden:true];
    //[_spinner stopAnimating];
    
}


// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Stops the spinner from spinning
    //[_spinner setHidden:true];
    //[_spinner stopAnimating];
    
}




// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Print the return data
    NSLog(@"%@",dataReturn);
    
    
    
    //Add the arrays to the table
    //Incase there are no results to return
    if([dataReturn  isEqual: @"null"])
    {
        //Do nothing
    }else{
        
        //Split up lists
        NSArray *lists = [dataReturn componentsSeparatedByString:@":"];
        
        
        //Test out names, wights, and ids
        [self updateArray:lists[0] withArrayToAddToo:0];
        [self updateArray:lists[1] withArrayToAddToo:1];
        [self updateArray:lists[2] withArrayToAddToo:2];
        [self updateArray:lists[3] withArrayToAddToo:3];
        
     
        //For each index add the cow information
        
        //Reload tableview
        [self.tableView reloadData];
        
    }
    
}






//Breaks down the string and updates the array
- (void) updateArray: (NSString*) rawString withArrayToAddToo:(int)arr
{
    //Cow IDs
    NSString *truncatedString = [rawString stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString = [truncatedString stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* array_return = [truncatedString componentsSeparatedByString:@","];
    
    //IDs: Iterate through each
    for(NSString* i in array_return)
    {
        NSString *ii = [i stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        //NSString *ii = i;
        
        NSLog(@"%@",ii);
        switch (arr) {
            case 0:
                [titleData addObject:ii];
                break;
            case 1:
                [costData addObject:ii];
                break;
            case 2:
                [descriptionData addObject:ii];
                break;
            case 3:
                [expenseIdData addObject:ii];
                break;
            
            
                
            default:
                break;
        }
        
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
