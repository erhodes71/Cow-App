//
//  ManageCowsViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/20/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "ManageCowsViewController.h"
#import "manageCowsTableViewCell.h"

@interface ManageCowsViewController ()
{
    //Data
    NSMutableArray* data;
    NSMutableArray* cowNames;
    NSMutableArray* weights;
    NSMutableArray* cowIDs;


}

@end

@implementation ManageCowsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //This is to initialize the data array
    data = [NSMutableArray arrayWithObjects:nil];
    
    //Cow names
    cowNames = [NSMutableArray arrayWithObjects:nil];
    
    //Cow weight
    weights = [NSMutableArray arrayWithObjects:nil];

    //Cow IDs
    cowIDs = [NSMutableArray arrayWithObjects:nil];
    
    [self loadCowData];
}




//If that cell is selected
//Needs to be able to take it to a window
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
    
}


//Gets the number of rows in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [cowNames count];
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
    
    cell.cowName.text = [cowNames objectAtIndex:indexPath.row];
    cell.weight.text = [weights objectAtIndex:indexPath.row];

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    
    //Can change the post data next
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
    
    NSLog(@"Test %@",cows_seperate_lists_data);
    
    //Split up lists
    NSArray *lists = [cows_seperate_lists_data componentsSeparatedByString:@":"];

    //Names
    NSString *truncatedString_names = [lists[0] stringByReplacingOccurrencesOfString:@"]" withString:@""];
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
    
    //For each index add the cow information
    
    //Reload tableview
    [self.tableView reloadData];

    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}





@end
