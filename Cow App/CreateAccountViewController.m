//
//  CreateAccountViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/17/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "CreateAccountViewController.h"

@interface CreateAccountViewController ()
{
    
    NSString* username_final;
    NSString* password_final;
}



@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Makes the comment hidden
    [self.commentLable setHidden:true];


}

//When the create account button is pressed
- (IBAction)createAccountButtonPressed:(id)sender {
    NSString *userName = _userNameTextField.text;
    NSString *password = _passwordTextField.text;
    NSString *password2 = _reEnterPasswordTextField.text;
    
    //Makes sure both strings are the same
    if([password isEqualToString:password2])
    {
        [self.commentLable setHidden:false];
        //self.commentLable.text = @"Worked";
        
        //Send request to create account
        //Should use the token you get back to set for the account
        //Along with the username and password that you set here
        [self sendPost:userName withPass:password];
        
    }else{
        [self.commentLable setHidden:false];
        //self.commentLable.text = @"Not so much";

    }
}

//This will close this window
- (IBAction)exitViewController:(id)sender {
    
    
    [self removeSelf];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Removes self from parent
-(void)removeSelf
{
    [self.view setHidden:true];
    [self.view removeFromSuperview];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_userNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_reEnterPasswordTextField resignFirstResponder];

    
}


//Send post
-(void)sendPost:(NSString*)username withPass:(NSString*)password
{
    //NSLog(@"%@",username);
    //NSLog(@"%@",password);
    
    //Used to keep track of username and password
    username_final = username;
    password_final = password;

    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/createAccount.php"]]];
    
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
    self.commentLable.text = @"Worked";
    
    
    //Need to make sure it returned a token
    // Just make sure the character length is 50
    NSUInteger len = token.length;
    
    if(len == 50){
        //Save data to the device
        
        //This loads the users data
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        
        //Save data
        [prefs setObject:username_final forKey:@"userID"];
        [prefs setObject:password_final forKey:@"password"];
        [prefs setObject:token forKey:@"accessToken"];
        [self removeSelf];

    }else{
        self.commentLable.text = @"There was an error processing this";

    }

}

// This method receives the error report in case of connection is not made to server.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    
}

// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
}

//This should re initialize the main view of the application
//This is used after the account is created
-(void)reIssueMainView
{
    //Clears this view
    //Does method to clear previous screen and re initilize the main view
    
    [self removeSelf];
}


@end
