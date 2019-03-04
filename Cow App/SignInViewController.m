//
//  SignInViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 8/15/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController{
    
    UIViewController* createAccountViewController;
    
    NSString* username;
    NSString* password;
    
    NSString* data_return;

    
    int hold;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Sets to 0 so that it is ready to process request
    hold = 0;
    
    //Data to return
    data_return = @"";
    
    //Rounds the corner radius of button
    _submitButton.layer.cornerRadius = 5.0;
}


//Create account button pressed
- (IBAction)createAccountButtonPressed:(id)sender {
    
    
    //Make create account page appear
    [self createAccountView];
}

-(void)createAccountView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    createAccountViewController = [storyboard instantiateViewControllerWithIdentifier:@"CreateAccountViewController"];
    [self addChildViewController:createAccountViewController];
    [self.view addSubview:createAccountViewController.view];
}




//Submit button was pressed
- (IBAction)submitButtonPressed:(id)sender {
    //Send request with the username and password to the server
    //Should recieve token
    //Then close window
    
    //Sets back to 0
    //hold = 0;
    
    //Sends the request
    [self sendLoginRequest];
    
    //while(hold == 0);
    
    //Goes back to 0
    //hold = 0;
    
}

-(void)sendLoginRequest
{
    
    
    
    
    username = _usernameTextField.text;
    password = _passwordTextField.text;
    
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/accountSignIn.php"]]];
    
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
    
    NSLog(@"Test %@",token);
    
    data_return = [NSString stringWithFormat:@"%@%@",data_return,token];
    
    
}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //If the data works, then close the window.
    //Else inform the user that they need to create an account
    if([data_return isEqualToString:@"This is not a current user."])
    {
        //Make this a comment on the app
        NSLog(@"Please create an account");
    }else{
        //Save the data to the device
        
        //Sets the token
        //NSString* token = requestReply;
        NSLog(@"Token: %@",data_return);
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSString *trimmedToken = [data_return stringByTrimmingCharactersInSet:
                                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //Save data
        [prefs setObject:username forKey:@"userID"];
        [prefs setObject:password forKey:@"password"];
        [prefs setObject:trimmedToken forKey:@"accessToken"];
        
        
        //close the window
        //[self.view setHidden:true];
        //[self.view removeFromSuperview];
        [self removeSelf];
    }
}

-(void)removeSelf
{
    NSLog(@"DATA: %@",data_return);
    
    [self.view setHidden:true];
    [self.view removeFromSuperview];
    [self.parentViewController viewDidLoad];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    
}

//
-(void)reIssueMainView
{
    //Clear this view and re init the main
    //[self removeSelf];
    //[self.parentViewController viewDidLoad];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
