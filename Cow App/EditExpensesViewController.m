//
//  EditExpensesViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/26/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "EditExpensesViewController.h"

@interface EditExpensesViewController (){
    
}

@end

@implementation EditExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Hides the spinner
    [_spinner setHidden:true];
    
    
    //Rounds all of the buttons
    _title_editButton.layer.cornerRadius = 5.0;
    _cost_editButton.layer.cornerRadius = 5.0;
    _description_editButton.layer.cornerRadius = 5.0;
    _removeButton.layer.cornerRadius = 5.0;
    
    
}

//Edit title
- (IBAction)title_editButtonPressed:(id)sender {
    
    [self sendRequest:@"title" withParameter:_titleTextField.text];
}

//Edit cost
- (IBAction)cost_editButtonPressed:(id)sender {
    
    [self sendRequest:@"cost" withParameter:_costTextField.text];

}

//Edit description
- (IBAction)description_editButtonPressed:(id)sender {
    
    [self sendRequest:@"description" withParameter:_descriptionTextView.text];

}

//Remove button pressed
- (IBAction)removeButtonPressed:(id)sender {
    //Send request to remove the expense
    [self sendDeleteRequest];
}




//Touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //[self.view setFrame:frame_origional];
    
    //This might be more efficent
    [self.view endEditing:YES];
    
}




//-----Sending request methods-----

//Delete Expense
-(void)sendDeleteRequest
{
    //Starts the spinner
    [_spinner setHidden:false];
    [_spinner startAnimating];
    
    
    
    //Load user data
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    NSString* cowID = [prefs stringForKey:@"CURRENT_EXP"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"userID=%@&token=%@&expID=%@",userName,token,cowID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/removeExpense.php"]]];
    
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



-(void)sendRequest: (NSString*)key withParameter:(NSString*) param
{
    //Starts the spinner
    [_spinner setHidden:false];
    [_spinner startAnimating];
    
    NSString* keys = @"userID=%@&token=%@&expID=%@&%@=%@";
    
    //Load user data
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    NSString* expID = [prefs stringForKey:@"CURRENT_EXP"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:keys,userName,token,expID,key,param];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/updateExpense.php"]]];
    
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
    
    //Stops the spinner from spinning
    [_spinner setHidden:true];
    [_spinner stopAnimating];
    
}


// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    //Stops the spinner from spinning
    [_spinner setHidden:true];
    [_spinner stopAnimating];
    
}


// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Stops the spinner from spinning
    [_spinner setHidden:true];
    [_spinner stopAnimating];
}




- (IBAction)backButtonPressed:(id)sender {
    
    [self removeSelf];
    [self.parentViewController viewDidLoad];
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



@end
