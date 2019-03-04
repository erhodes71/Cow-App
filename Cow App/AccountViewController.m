//
//  AccountViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/17/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController (){
    
    NSString *newPassword;
    bool confirmedPass;
}

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //Load username
    [self getUserData];
    confirmedPass = false;
    
    //Rounds the buttons
    _updateButton.layer.cornerRadius = 5.0;
    _submitButton.layer.cornerRadius = 5.0;
    _logoutButton.layer.cornerRadius = 5.0;
    
    //Spinner
    [_spinner setHidden:true];
    //[_spinner stopAnimating];
    
}


- (void) getUserData
{
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* password = [prefs stringForKey:@"password"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    
    _usernameLabel.text = userName;
}


//If the back button is pressed
- (IBAction)backButtonPressed:(id)sender {
    
    //Remove the view
    [self removeSelf];
    //Make the viewdidLoad function happen
}

//The submit button has been pressed
- (IBAction)submitButtonPressed:(id)sender {
    //Send post request with new password, assuming the old one fits
    //Can make an update password script and send it
    
    [_spinner setHidden:false];
    [_spinner startAnimating];
    
    //Call function
    [self changeCurrentPassword];
    
    
    
    
}

//Update button was pressed
- (IBAction)updateButtonPressed:(id)sender {
    
    
    [_spinner setHidden:false];
    [_spinner startAnimating];
    [self updateMonthlyBudget];
   
}




-(void) updateMonthlyBudget
{
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    //NSString* password = [prefs stringForKey:@"password"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    NSString* budget = _monthlyBudgetTextField.text;
    //Used to keep track of username and password
    //username_final = username;
    //password_final = password;
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"userID=%@&token=%@&budget=%@",userName,token,budget];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/updateMonthlyBudget.php"]]];
    
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


//Changes the password, assuming the current one works
- (void) changeCurrentPassword
{
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* password = [prefs stringForKey:@"password"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    
    NSString *oldPassword = _oldPasswordTextField.text;
    
    newPassword = _PasswordTextField.text;
    NSString *newPassword2 = _reTypeNewPasswordTextField.text;
    
    NSLog(@"Pass: %@",password);
    NSLog(@"Old: %@",oldPassword);
    //Checks if the password works
    if([oldPassword isEqualToString:password])
    {
        //Checks to make sure both are the same
        if([newPassword isEqualToString:newPassword2]){
            [self sendPost:userName withPass:newPassword withToken:token];
            confirmedPass = true;
        }
    }else{
        NSLog(@"Old password is ");
    }
    
}

//Logout button is pressed
- (IBAction)logoutButtonPressed:(id)sender {
    //Clear current data on the device
    //Go to home screen
    [self logout];
    [self removeSelf];
    //[self.parentViewController viewDidLoad];
}

- (void)logout
{
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    
    //Save data
    [prefs setObject:@"" forKey:@"userID"];
    [prefs setObject:@"" forKey:@"password"];
    [prefs setObject:@"" forKey:@"accessToken"];
}



-(void)removeSelf
{
    [self.parentViewController viewDidLoad];
    [self.view setHidden:true];
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Sending post request data
//-------------------------

//Send post
-(void)sendPost:(NSString*)username withPass:(NSString*)password withToken:(NSString*)token
{
    NSLog(@"Username: %@",username);
    NSLog(@"Password: %@",password);
    NSLog(@"Token: %@",token);

    
    //Used to keep track of username and password
    //username_final = username;
    //password_final = password;
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&token=%@",username,password,token];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/updatePassword.php"]]];
    
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
    NSString *token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSUInteger length = [token length];
    bool isToken = false;
    if(length == 50)
    {
        isToken = true;
    }
    
    NSLog(@"Test %@",token);
    
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
   
    
    //Set the data to new
    if(confirmedPass && isToken)
    {
        //Save data
        [prefs setObject:newPassword forKey:@"password"];
        [prefs setObject:token forKey:@"accessToken"];
        
        _commentLabel.text = @"Password updated";
        
        confirmedPass = false;

    }
    
    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}


//Touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_oldPasswordTextField resignFirstResponder];
    [_PasswordTextField resignFirstResponder];
    [_reTypeNewPasswordTextField resignFirstResponder];
    [_monthlyBudgetTextField resignFirstResponder];
    
    
}


// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Stops and hides spinner
    [_spinner setHidden:true];
    [_spinner stopAnimating];
}



@end
