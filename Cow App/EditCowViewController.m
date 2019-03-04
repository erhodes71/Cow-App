//
//  EditCowViewController.m
//  Cow App
//
//  Created by Eric Rhodes on 2/22/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "EditCowViewController.h"

@interface EditCowViewController ()
{
    
    UIViewController* moreInfoViewController;
    CGRect frame_origional;

}

@end

@implementation EditCowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Sets to hidden
    [_spinner setHidden:true];
    
    //Save the current cow to be used for following view
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *cowID = [prefs stringForKey:@"CURRENT_COW_ID"];
    _testLabel.text = cowID;
    
    
    
    //Set standard frame
    frame_origional = [self.view frame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    _moreButton.layer.cornerRadius = 5.0;
    _edit_nameButton.layer.cornerRadius = 5.0;
    _editDOBButton.layer.cornerRadius = 5.0;
    _editDPButton.layer.cornerRadius = 5.0;
    _edit_amountPaidButton.layer.cornerRadius = 5.0;
    _edit_amountSoldButton.layer.cornerRadius = 5.0;
    _update_weightButton.layer.cornerRadius = 5.0;
    _add_vaccButton.layer.cornerRadius = 5.0;
    _update_commentButton.layer.cornerRadius = 5.0;
    
    _removeCowButton.layer.cornerRadius = 5.0;
    
    
    
}


//Back button was pressed
- (IBAction)backButtonPressed:(id)sender {
    
    [self.parentViewController viewDidLoad];
    [self removeSelf];
    
}


//Sends to next view
- (IBAction)moreButtonPressed:(id)sender {
    
    [self loadMoreInformationView];
    
}


- (void) loadMoreInformationView{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    moreInfoViewController = [storyboard instantiateViewControllerWithIdentifier:@"MoreInfoViewController"];
    [self addChildViewController:moreInfoViewController];
    [self.view addSubview:moreInfoViewController.view];
}






//Removes self from parent
-(void)removeSelf
{
    [self.view setHidden:true];
    [self.view removeFromSuperview];
}


//Touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //[_userNameTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    [_birthDateTextField resignFirstResponder];
    [_datePurchasedTextField resignFirstResponder];
    [_amountPaidTextField resignFirstResponder];
    [_amountSoldTextField resignFirstResponder];
    [_weightTextField resignFirstResponder];
    [_vaccinationTextField resignFirstResponder];
    [_commentTextView resignFirstResponder];
    
    
    [self.view setFrame:frame_origional];
    
    //This might be more efficent
    //[self.view endEditing:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Keyboard
- (void)keyboardWillShow:(NSNotification*)aNotification {
    
    if([_commentTextView isFirstResponder]){
        [UIView animateWithDuration:0.25 animations:^
         {
             CGRect newFrame = [self.view frame];

             //newFrame.origin.y -= 250; // tweak here to adjust the moving position
             newFrame.origin.y = -1*(self->frame_origional.size.width/2);
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
             [self.view setFrame:frame_origional];
             
         }completion:^(BOOL finished)
         {
             
         }];
        
    //}
   
    
}

//----Button Functinos------

//Name button edit hit
- (IBAction)name_editButtonPressed:(id)sender {
    [self sendRequest:@"name" withValue:_nameTextField.text];
}


- (IBAction)DB_editButtonPressed:(id)sender {
    [self sendRequest:@"dateBirth" withValue:_birthDateTextField.text];
}


- (IBAction)DP_ButtonPressed:(id)sender {
    [self sendRequest:@"datePurchased" withValue:_datePurchasedTextField.text];
}


- (IBAction)amoundPaid_ButtonPressed:(id)sender {
    [self sendRequest:@"amountBought" withValue:_amountPaidTextField.text];
}


- (IBAction)amountSold_ButtonPressed:(id)sender {
    [self sendRequest:@"amountSold" withValue:_amountSoldTextField.text];
}


- (IBAction)weight_ButtonPressed:(id)sender {
    [self sendRequest:@"weightCurrent" withValue:_weightTextField.text];
}


- (IBAction)vaccination_ButtonPressed:(id)sender {
    [self sendRequest:@"vaccinations" withValue:_vaccinationTextField.text];
}


- (IBAction)comment_ButtonPressed:(id)sender {
    [self sendRequest:@"calfInfo" withValue:_commentTextView.text];
}


- (IBAction)removeButtonPressed:(id)sender {
    [self sendDeleteRequest];
}





//---------------------



//-----Sending request methods-----


//Deletes the cow 
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
    NSString* cowID = [prefs stringForKey:@"CURRENT_COW_ID"];
    
    //Can change the post data next
    NSString *post = [NSString stringWithFormat:@"userID=%@&token=%@&cowID=%@",userName,token,cowID];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    //[request setURL:[NSURL URLWithString:@"https://erhodes.oucreate.com/Cows/test.php"]];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://erhodes.oucreate.com/Cows/removeCow.php"]]];
    
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


// This method is used to process the data after connection has made successfully.
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //Stops the spinner from spinning
    [_spinner setHidden:true];
    [_spinner stopAnimating];
}













-(void)testFunction
{
    NSLog(@"This is a test");
}


@end
