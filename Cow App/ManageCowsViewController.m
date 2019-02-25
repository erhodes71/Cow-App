//
//  ManageCowsViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/20/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "ManageCowsViewController.h"
#import "manageCowsTableViewCell.h"
#import "EditCowViewController.h"

@interface ManageCowsViewController ()
{
    //Data
    NSMutableArray* data;
    NSMutableArray* cowNames;
    NSMutableArray* weights;
    NSMutableArray* cowIDs;
    
    NSMutableArray* DOBs;
    NSMutableArray* dPurchased;
    NSMutableArray* brands;
    NSMutableArray* weightTimeLine;
    NSMutableArray* amoundPaid;
    NSMutableArray* amountSold;
    NSMutableArray* weightBought;
    NSMutableArray* weightSold;
    NSMutableArray* calfInfo;
    NSMutableArray* vaccs;
    NSMutableArray* timeLines;
    NSMutableArray* parents1s;
    NSMutableArray* parents2s;
    NSMutableArray* owned;
    NSMutableArray* isAlive;
    NSMutableArray* isRegistered;
    NSMutableArray* boughtFrom;
    NSMutableArray* soldTo;


    

    UIViewController* editCowViewController;

    UIViewController* addCowViewController;
    
    
    NSString* dataFromRequest;

}

@end

@implementation ManageCowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //This will be data that is collected
    dataFromRequest = @"";
    
    
    
    //Rounds corner of button
    _addCow.layer.cornerRadius = 5.0;
    
    
    
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    
    //Cow names
    cowNames = [NSMutableArray arrayWithObjects:nil];
    
    //Cow weight
    weights = [NSMutableArray arrayWithObjects:nil];

    //Cow IDs
    cowIDs = [NSMutableArray arrayWithObjects:nil];
    
    //Date of birth
    DOBs = [NSMutableArray arrayWithObjects:nil];
    
    //Date purchased
    dPurchased = [NSMutableArray arrayWithObjects:nil];
    
    //Brands
    brands = [NSMutableArray arrayWithObjects:nil];
    
    //Weight Time Line
    weightTimeLine = [NSMutableArray arrayWithObjects:nil];
    
    //Amount Paid
    amoundPaid = [NSMutableArray arrayWithObjects:nil];
    
    //Amount Sold
    amountSold = [NSMutableArray arrayWithObjects:nil];
    
    //Weight Bought
    weightBought = [NSMutableArray arrayWithObjects:nil];
    
    //Weight Sold
    weightSold = [NSMutableArray arrayWithObjects:nil];
    
    //Calf Info
    calfInfo = [NSMutableArray arrayWithObjects:nil];
    
    //Vaccinations
    vaccs = [NSMutableArray arrayWithObjects:nil];
    
    //Timelines - dates that edits where made
    timeLines = [NSMutableArray arrayWithObjects:nil];
    
    //Parent 1
    parents1s = [NSMutableArray arrayWithObjects:nil];
    
    //Parent 2
    parents2s = [NSMutableArray arrayWithObjects:nil];
    
    //Owned - bool
    owned = [NSMutableArray arrayWithObjects:nil];
    
    //If is still alive
    isAlive = [NSMutableArray arrayWithObjects:nil];
    
    //Is registered
    isRegistered = [NSMutableArray arrayWithObjects:nil];
    
    //Bought from
    boughtFrom = [NSMutableArray arrayWithObjects:nil];
    
    //Sold to
    soldTo = [NSMutableArray arrayWithObjects:nil];
    
    
    [self loadCowData];
}




//If that cell is selected
//Needs to be able to take it to a window
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    
    //Save the current cow to be used for following view
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *cowID = cowIDs[(int)indexPath.row];
    [prefs setObject:cowID forKey:@"CURRENT_COW_ID"];
    
    NSLog(@"Cow ID: %@",cowID);
    
    
    
    
    
    //Go to Cow information page here
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    editCowViewController = [storyboard instantiateViewControllerWithIdentifier:@"EditCowViewController"];
    [self addChildViewController:editCowViewController];
    [self.view addSubview:editCowViewController.view];
    
    

}


//Gets the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [cowIDs count];
}




//Adds the cell based on the data
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"manageCowsTableViewCell";
    
    manageCowsTableViewCell *cell = (manageCowsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"manageCowsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        
    }
    
    //Note: for date and times, for now we need to stick with - instead of /. Just for now.
    
    cell.cowName.text = [cowNames objectAtIndex:indexPath.row];
    cell.weight.text = [weights objectAtIndex:indexPath.row];
    cell.dateOfBirth.text = [DOBs objectAtIndex:indexPath.row];
    cell.datePurchased.text = [dPurchased objectAtIndex:indexPath.row];
    cell.brand.text = [brands objectAtIndex:indexPath.row];
    cell.weightTimeLine.text = [weightTimeLine objectAtIndex:indexPath.row];
    cell.amountPaid.text = [amoundPaid objectAtIndex:indexPath.row];
    cell.weightBought.text = [weightBought objectAtIndex:indexPath.row];
    cell.amountSold.text = [amountSold objectAtIndex:indexPath.row];
    cell.weightSold.text = [weightSold objectAtIndex:indexPath.row];
    
    //Needs to be broken appart
    NSString* linesOfVaccs = [vaccs objectAtIndex:indexPath.row];
    NSArray* linesV = [linesOfVaccs componentsSeparatedByString:@"!"];
    //NSString* linesOfInfo = [calfInfo objectAtIndex:indexPath.row];
    NSString* outPut_vaccs = @"";
    for(NSString* s in linesV)
    {
        if(![s isEqualToString:@""]){
            NSLog(@"TEST: %@",s);
            outPut_vaccs = [NSString stringWithFormat:@"%@%@\n---------\n",outPut_vaccs,s];
        }
    }
    cell.vaccinations.text = outPut_vaccs;//[vaccs objectAtIndex:indexPath.row];
    
    cell.parent1.text = [parents1s objectAtIndex:indexPath.row];
    cell.parent2.text = [parents2s objectAtIndex:indexPath.row];
    cell.owned.text = [owned objectAtIndex:indexPath.row];
    cell.isAlive.text = [isAlive objectAtIndex:indexPath.row];
    cell.isRegistered.text = [isRegistered objectAtIndex:indexPath.row];
    cell.boughtFrom.text = [boughtFrom objectAtIndex:indexPath.row];
    cell.soldTo.text = [soldTo objectAtIndex:indexPath.row];
    
    //Calf info and timestamps. Both split by ! so you should be able to iterate through it.
    NSString* linesOfInfo = [calfInfo objectAtIndex:indexPath.row];
    NSArray* lines = [linesOfInfo componentsSeparatedByString:@"!"];
    //NSString* linesOfInfo = [calfInfo objectAtIndex:indexPath.row];
    NSString* outPut_calfInfo = @"";
    for(NSString* s in lines)
    {
        if(![s isEqualToString:@""]){
            NSLog(@"TEST: %@",s);
            outPut_calfInfo = [NSString stringWithFormat:@"%@%@\n---------\n",outPut_calfInfo,s];
        }
    }
    cell.information.text = outPut_calfInfo; //[calfInfo objectAtIndex:indexPath.row];


    

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 690;
    // This is just Programatic method you can also do that by xib !
}


//Back button was pressed
- (IBAction)backButtonPressed:(id)sender {
    
    //Call remove self function
    [self removeSelf];
    
    
}


//Removes self from parent
-(void)removeSelf
{
    [self.view setHidden:true];
    [self.view removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//--- Post functions

-(void)loadCowData
{
    
    
    
    //Load user data
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    
    //Can change the post data next dataUsingEncoding:NSUTF8StringEncoding
    NSString *post = [NSString stringWithFormat:@"userID=%@&token=%@&q=%@",userName,token,@"QueryByName"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/getListOfCows.php"]]];
    
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
    NSString *cows_seperate_lists_data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    dataFromRequest = [NSString stringWithFormat:@"%@%@",dataFromRequest,cows_seperate_lists_data];
    
    //NSLog(@"Test %@",cows_seperate_lists_data);
    /*
    //Incase there are no results to return
    if([cows_seperate_lists_data  isEqual: @"null"])
    {
       //Do nothing
    }else{
    
    //Split up lists
    NSArray *lists = [cows_seperate_lists_data componentsSeparatedByString:@":"];*/

    //Names
    /*NSString *truncatedString_names = [lists[0] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString_names = [truncatedString_names stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* names = [truncatedString_names componentsSeparatedByString:@","];
    
    //Weights
    NSString *truncatedString_weights = [lists[1] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString_weights = [truncatedString_weights stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* weights_array = [truncatedString_weights componentsSeparatedByString:@","];
    
    //Cow IDs
    NSString *truncatedString_ID = [lists[2] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString_ID = [truncatedString_ID stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* ID_array = [truncatedString_ID componentsSeparatedByString:@","];
    
    
    //Date of births
    NSString *truncatedString_DOB = [lists[3] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString_DOB = [truncatedString_DOB stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* DOB_array = [truncatedString_DOB componentsSeparatedByString:@","];
    
    //Date purchased
    NSString *truncatedString_DP = [lists[4] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString_DP = [truncatedString_DP stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* DP_array = [truncatedString_DP componentsSeparatedByString:@","];
    
    //Brands
    NSString *truncatedString_brands = [lists[5] stringByReplacingOccurrencesOfString:@"]" withString:@""];
    truncatedString_brands = [truncatedString_brands stringByReplacingOccurrencesOfString:@"[" withString:@""];
    NSArray* brands_array = [truncatedString_brands componentsSeparatedByString:@","];
    
    
    
    //names: Iterate through each
    for(NSString* n in names)
    {
        NSString *nn = [n stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        
        NSLog(@"%@",nn);
        [cowNames addObject:nn];
    }
    
    //weights: Iterate through each
    for(NSString* w in weights_array)
    {
        NSString *ww = [w stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"%@",ww);
        [weights addObject:ww];
    }
    
    //IDs: Iterate through each
    for(NSString* i in ID_array)
    {
        NSString *ii = [i stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"%@",ii);
        [cowIDs addObject:ii];
    }
    
    //DOBs: Iterate through each
    for(NSString* i in DOB_array)
    {
        NSString *ii = [i stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"%@",ii);
        [DOBs addObject:ii];
    }
    
    //DP: Iterate through each
    for(NSString* i in DP_array)
    {
        NSString *ii = [i stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"%@",ii);
        [dPurchased addObject:ii];
    }
    
    //DP: Iterate through each
    for(NSString* i in brands_array)
    {
        NSString *ii = [i stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"%@",ii);
        [brands addObject:ii];
    }
    */
    //Test out names, wights, and ids
    /*[self updateArray:lists[0] withArrayToAddToo:0];
    [self updateArray:lists[1] withArrayToAddToo:1];
    [self updateArray:lists[2] withArrayToAddToo:2];
    [self updateArray:lists[3] withArrayToAddToo:3];
    [self updateArray:lists[4] withArrayToAddToo:4];
    [self updateArray:lists[5] withArrayToAddToo:5];
    [self updateArray:lists[6] withArrayToAddToo:6];
    [self updateArray:lists[7] withArrayToAddToo:7];
    [self updateArray:lists[8] withArrayToAddToo:8];
    [self updateArray:lists[9] withArrayToAddToo:9];
    [self updateArray:lists[10] withArrayToAddToo:10];
    [self updateArray:lists[11] withArrayToAddToo:11];
    [self updateArray:lists[12] withArrayToAddToo:12];
    [self updateArray:lists[13] withArrayToAddToo:13];
    [self updateArray:lists[14] withArrayToAddToo:14];
    [self updateArray:lists[15] withArrayToAddToo:15];
    [self updateArray:lists[16] withArrayToAddToo:16];
    [self updateArray:lists[17] withArrayToAddToo:17];
    [self updateArray:lists[18] withArrayToAddToo:18];
    [self updateArray:lists[19] withArrayToAddToo:19];
    [self updateArray:lists[20] withArrayToAddToo:20];



    
    //For each index add the cow information
    
    //Reload tableview
    [self.tableView reloadData];*/

    //}
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
                [cowNames addObject:ii];
                break;
            case 1:
                [weights addObject:ii];
                break;
            case 2:
                [cowIDs addObject:ii];
                break;
            case 3:
                [DOBs addObject:ii];
                break;
            case 4:
                [dPurchased addObject:ii];
                break;
            case 5:
                [brands addObject:ii];
                break;
            case 6:
                [weightTimeLine addObject:ii];
                break;
            case 7:
                [amoundPaid addObject:ii];
                break;
            case 8:
                [amountSold addObject:ii];
                break;
            case 9:
                [weightBought addObject:ii];
                break;
            case 10:
                [weightSold addObject:ii];
                break;
            case 11:
                [calfInfo addObject:ii];
                break;
            case 12:
                [vaccs addObject:ii];
                break;
            case 13:
                [timeLines addObject:ii];
                break;
            case 14:
                [parents1s addObject:ii];
                break;
            case 15:
                [parents2s addObject:ii];
                break;
            case 16:
                [owned addObject:ii];
                break;
            case 17:
                [isAlive addObject:ii];
                break;
            case 18:
                [isRegistered addObject:ii];
                break;
            case 19:
                [boughtFrom addObject:ii];
                break;
            case 20:
                [soldTo addObject:ii];
                break;
                
            default:
                break;
        }
        
    }
    
    //return array_return;
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"This is a test.");
    
    //Converts the data
    //NSString *cows_seperate_lists_data = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    
    
    NSLog(@"Test %@",dataFromRequest);
    
    //Incase there are no results to return
    if([dataFromRequest  isEqual: @"null"])
    {
        //Do nothing
    }else{
        
        //Split up lists
        NSArray *lists = [dataFromRequest componentsSeparatedByString:@":"];
        
        
        //Test out names, wights, and ids
         [self updateArray:lists[0] withArrayToAddToo:0];
         [self updateArray:lists[1] withArrayToAddToo:1];
         [self updateArray:lists[2] withArrayToAddToo:2];
         [self updateArray:lists[3] withArrayToAddToo:3];
         [self updateArray:lists[4] withArrayToAddToo:4];
         [self updateArray:lists[5] withArrayToAddToo:5];
         [self updateArray:lists[6] withArrayToAddToo:6];
         [self updateArray:lists[7] withArrayToAddToo:7];
         [self updateArray:lists[8] withArrayToAddToo:8];
         [self updateArray:lists[9] withArrayToAddToo:9];
         [self updateArray:lists[10] withArrayToAddToo:10];
         [self updateArray:lists[11] withArrayToAddToo:11];
         [self updateArray:lists[12] withArrayToAddToo:12];
         [self updateArray:lists[13] withArrayToAddToo:13];
         [self updateArray:lists[14] withArrayToAddToo:14];
         [self updateArray:lists[15] withArrayToAddToo:15];
         [self updateArray:lists[16] withArrayToAddToo:16];
         [self updateArray:lists[17] withArrayToAddToo:17];
         [self updateArray:lists[18] withArrayToAddToo:18];
         [self updateArray:lists[19] withArrayToAddToo:19];
         [self updateArray:lists[20] withArrayToAddToo:20];
         
         
         
         
         //For each index add the cow information
         
         //Reload tableview
         [self.tableView reloadData];
        
    }
}

//Add cow button pressed
//Creates new view
- (IBAction)addCowButtonPressed:(id)sender {
    
    //Go to Cow information page here
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    addCowViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddCowViewController"];
    [self addChildViewController:addCowViewController];
    [self.view addSubview:addCowViewController.view];
}








@end
