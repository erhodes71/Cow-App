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
    
    int hold;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Sets to 0 so that it is ready to process request
    hold = 0;
}


//Create account button pressed
- (IBAction)createAccountButtonPressed:(id)sender {
    
    
    //Make create account page appear
}




//Submit button was pressed
- (IBAction)submitButtonPressed:(id)sender {
    //Send request with the username and password to the server
    //Should recieve token
    //Then close window
    
    //Sets back to 0
    hold = 0;
    
    //Sends the request
    [self sendLoginRequest];
    
    while(hold == 0);
    
    //Goes back to 0
    hold = 0;
    
}

-(void)sendLoginRequest
{
    
    NSString* username = _usernameTextField.text;
    NSString* password = _passwordTextField.text;
    
    //Change this
    NSString* url = [NSString stringWithFormat:@"http://erhodes.oucreate.com/Cows/accountSignIn.php?username=%@&password=%@",username,password];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
        
        //If the data works, then close the window.
        //Else inform the user that they need to create an account
        if([requestReply isEqualToString:@"This is not a current user."])
        {
            //Make this a comment on the app
            NSLog(@"Please create an account");
        }else{
            //Save the data to the device
            
            //Sets the token
            NSString* token = requestReply;
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            //Save data
            [prefs setObject:username forKey:@"userID"];
            [prefs setObject:password forKey:@"password"];
            [prefs setObject:token forKey:@"token"];
            
            
            //close the window
            [self.view setHidden:true];
            [self.view removeFromSuperview];
        }
        
        
        //Sets so that the task can finish
        self->hold = 1;
        
        
    }] resume];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
