//
//  AddCowViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/24/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "AddCowViewController.h"

@interface AddCowViewController ()
{
    //Keeps track of vaccinations added
    NSString* vaccinations;
    
    
    CGRect frame_origional;
    
    NSString* registared;
}



@end

@implementation AddCowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_spinner setHidden:true];
    [_spinner stopAnimating];
    
    //Sets blank
    vaccinations = @"";
    registared = @"";
    
    
    //Makes the buttons have rounded corners
    _submitButton.layer.cornerRadius = 5.0;
    _addButton.layer.cornerRadius = 5.0;
    _trueButton.layer.cornerRadius = 5.0;
    _falseButton.layer.cornerRadius = 5.0;
    
    //Makes the textView have rounded corners
    _commentTextView.layer.cornerRadius = 5.0;
    
    
    
    //Set standard frame
    frame_origional = [self.view frame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}


//Back button was pressed
- (IBAction)backButtonPressed:(id)sender {
    [self.parentViewController viewDidLoad];
    [self removeSelf];
}



//Submit button pressed
- (IBAction)submitButtonPressed:(id)sender {
    [self sendRequest];
}

//Add button pressed
- (IBAction)addButtonPressed:(id)sender {
    if([vaccinations isEqualToString:@""]){
        vaccinations = [NSString stringWithFormat:@"%@!",_vaccinationTextField.text];
        [_vaccinationTextField setText:@""];
        NSLog(@"Vaccs: %@", vaccinations);
    }else{
        vaccinations = [NSString stringWithFormat:@"%@%@!",vaccinations,_vaccinationTextField.text];
        [_vaccinationTextField setText:@""];
        NSLog(@"Vaccs: %@", vaccinations);
    }
}

//True button pressed
- (IBAction)trueButtonPressed:(id)sender {
    [_falseButton setSelected:false];
    [_trueButton setSelected:true];
    [_trueButton setHighlighted:true];
    [_falseButton setHighlighted:false];
    registared = @"TRUE";
    NSLog(@"Registared: %@", registared);
}

//False button pressed
- (IBAction)falseButtonPressed:(id)sender {
    [_falseButton setSelected:true];
    [_trueButton setSelected:false];
    [_trueButton setHighlighted:false];
    [_falseButton setHighlighted:true];
    registared = @"FALSE";
    NSLog(@"Registared: %@", registared);
}











//Keyboard
- (void)keyboardWillShow:(NSNotification*)aNotification {
    
    
    if([_commentTextView isFirstResponder]){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = self->frame_origional;
             
             newFrame.origin.y -= 255; // tweak here to adjust the moving position
             //newFrame.origin.y = -1*(self->frame_origional.size.width/2);
             [self.view setFrame:newFrame];
             
         }completion:^(BOOL finished)
         {
             
         }];
    }else if([_boughtFromTextField isFirstResponder]){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = self->frame_origional;
             
             newFrame.origin.y -= 200; // tweak here to adjust the moving position
             //newFrame.origin.y = -1*(self->frame_origional.size.width/2);
             [self.view setFrame:newFrame];
             
         }completion:^(BOOL finished)
         {
             
         }];
    }else if([_parent2TextField isFirstResponder]){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = self->frame_origional;
             
             newFrame.origin.y -= 200; // tweak here to adjust the moving position
             //newFrame.origin.y = -1*(self->frame_origional.size.width/2);
             [self.view setFrame:newFrame];
             
         }completion:^(BOOL finished)
         {
             
         }];
    }else if([_parent1TextField isFirstResponder]){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = self->frame_origional;
             
             newFrame.origin.y -= 200; // tweak here to adjust the moving position
             //newFrame.origin.y = -1*(self->frame_origional.size.width/2);
             [self.view setFrame:newFrame];
             
         }completion:^(BOOL finished)
         {
             
         }];
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    
    
    //if([_commentTextView isFirstResponder]){
    [UIView animateWithDuration:0.25 animations:^
     {
         CGRect newFrame = [self.view frame];
         newFrame.origin.y += 50; // tweak here to adjust the moving position
         [self.view setFrame:self->frame_origional];
         
     }completion:^(BOOL finished)
     {
         
     }];
    
    //}
    
    
}

//Touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //[self.view setFrame:frame_origional];
    
    //This might be more efficent
    [self.view endEditing:YES];
    
}



//-----Sending request methods-----

-(void)sendRequest
{
    //Starts the spinner
    [_spinner setHidden:false];
    [_spinner startAnimating];
    
    NSString* keys = @"userID=%@&token=%@&name=%@&dateBirth=%@&datePurchased=%@&amountBought=%@&weightCurrent=%@&vaccinations=%@&brand=%@&weightBirth=%@&parent1=%@&parent2=%@&boughtFrom=%@&isRegistered=%@&calfInfo=%@";
    
    //Load user data
    //This loads the users data
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString* userName = [prefs stringForKey:@"userID"];
    NSString* token = [prefs stringForKey:@"accessToken"];
    //NSString* cowID = [prefs stringForKey:@"CURRENT_COW_ID"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:keys,userName,token,_nameTextField.text,_birthDateTextField.text,_datePurchasedTextField.text,_amountPaidTextField.text,_weightTextField.text,vaccinations,_brandTextField.text,_weightBirthTextField.text,_parent1TextField.text,_parent2TextField.text,_boughtFromTextField.text,registared,_commentTextView.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/addCow.php"]]];
    
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
