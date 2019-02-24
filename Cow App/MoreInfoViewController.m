//
//  MoreInfoViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/23/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "MoreInfoViewController.h"

@interface MoreInfoViewController ()

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Hides the spinner
    [_spinner setHidden:true];
    
    
    _edit_brandButton.layer.cornerRadius = 5.0;
    _edit_weightBoughtButton.layer.cornerRadius = 5.0;
    _edit_weightSoldButton.layer.cornerRadius = 5.0;
    _edit_parent1Button.layer.cornerRadius = 5.0;
    _edit_parent2Button.layer.cornerRadius = 5.0;
    _edit_boughtFromButton.layer.cornerRadius = 5.0;
    _edit_soldToButton.layer.cornerRadius = 5.0;

    _true_ownedButton.layer.cornerRadius = 5.0;
    _false_ownedButton.layer.cornerRadius = 5.0;

    _true_isAliveButton.layer.cornerRadius = 5.0;
    _false_isAliveButton.layer.cornerRadius = 5.0;

    _true_registaredButton.layer.cornerRadius = 5.0;
    _false_registaredButton.layer.cornerRadius = 5.0;
}



//Back button was pressed
- (IBAction)backButtonPressed:(id)sender {
    
    [self removeSelf];
}

//Touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    //This might be more efficent
    [self.view endEditing:YES];
    
}


//Removes self from parent
-(void)removeSelf
{
    [self.view setHidden:true];
    [self.view removeFromSuperview];
}


//Edit button pressed
- (IBAction)brand_editButtonPressed:(id)sender {
    [self sendRequest:@"brand" withValue:_brandTextField.text];
}

//Weight bought button pressed
- (IBAction)weightBought_editButtonPressed:(id)sender {
    [self sendRequest:@"weightBought" withValue:_weightBoughtTextField.text];
}

//Weight Sold button pressed
- (IBAction)weightSold_editButtonPressed:(id)sender {
    [self sendRequest:@"weightSold" withValue:_weightSoldTextField.text];
}

//Parent1 button pressed
- (IBAction)parent1_editButtonPressed:(id)sender {
    [self sendRequest:@"parent1" withValue:_parent1TextField.text];
}

//Parent2 button pressed
- (IBAction)parent2_editButtonPressed:(id)sender {
    [self sendRequest:@"parent2" withValue:_parent2TextField.text];
}

//Bought From button pressed
- (IBAction)boughtFrom_editButtonPressed:(id)sender {
    [self sendRequest:@"boughtFrom" withValue:_boughtFromTextField.text];
}

//Sold to button pressed
- (IBAction)soldTo_editButtonPressed:(id)sender {
    [self sendRequest:@"soldTo" withValue:_soldToTextField.text];
}



//True false buttons

- (IBAction)ownedTrueButtonPressed:(id)sender {
    [self sendRequest:@"isOwnedByUser" withValue:@"TRUE"];
}
- (IBAction)ownedFalseButtonPressed:(id)sender {
    [self sendRequest:@"isOwnedByUser" withValue:@"FALSE"];
}


- (IBAction)isAliveTrueButtonPressed:(id)sender {
    [self sendRequest:@"isAlive" withValue:@"TRUE"];
}
- (IBAction)isAliveFalseButtonPressed:(id)sender {
    [self sendRequest:@"isAlive" withValue:@"FALSE"];
}


- (IBAction)registeredTrueButtonPressed:(id)sender {
    [self sendRequest:@"isRegistered" withValue:@"TRUE"];
}
- (IBAction)registeredFalseButtonPressed:(id)sender {
    [self sendRequest:@"isRegistered" withValue:@"FALSE"];
}



//-----Sending request methods-----

-(void)sendRequest: (NSString*)reqType withValue:(NSString*)value
{
    //Starts the spinner
    [_spinner setHidden:false];
    [_spinner startAnimating];
    
    
    
    //Load user data
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    NSString* cowID = [prefs stringForKey:@"CURRENT_COW_ID"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"userID=%@&token=%@&cowID=%@&%@=%@",userName,token,cowID,reqType,value];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/updateCow.php"]]];
    
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




















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
