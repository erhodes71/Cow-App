//
//  mainViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 8/15/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "mainViewController.h"
#import "mainTableViewCell.h"

@interface mainViewController ()

@end

@implementation mainViewController
{
    
    
    NSMutableArray* data;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    
}

//This method is used to check if the user is on the device
-(void)checkCredentials
{

    //Load
    //  Username
    //  Password
    //  Token
    
    
    
    //Check if username exists
        //If it does
            //then try and log in and retrieve the token
            //then have it Initialsize View
        //Else
            //Send them to the account sign-in view
}


-(void)InitializeView
{
    //Loads the table view full of information on the recent activity on the account.
    //Loads the total number of cows
    //Loads the cost per month
    
}

//If the account button is pressed
- (IBAction)accountButtonPressed:(id)sender {
    
    
}

//Action button is pressed
- (IBAction)actionButtonPressed:(id)sender {
    
    
}

//Manage herd button is pressed
- (IBAction)manageHerdButtonPressed:(id)sender {
    
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
    /*NSUInteger check;
     //Note:
     //  Make sure to have a check here or else it will just populate it with an empty field
     if(start){
     check = 0;
     }
     else{
     check = [titleData count];
     }*/
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
