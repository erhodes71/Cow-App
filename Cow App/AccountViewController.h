//
//  AccountViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/17/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "ViewController.h"

@interface AccountViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *reTypeNewPasswordTextField;


@property (weak, nonatomic) IBOutlet UITextField *monthlyBudgetTextField;




@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@property (weak, nonatomic) IBOutlet UIButton *updateButton;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *logoutButton;



@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;










@end
