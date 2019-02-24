//
//  EditCowViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/22/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCowViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *testLabel;






@property (weak, nonatomic) IBOutlet UIButton *moreButton;


@property (weak, nonatomic) IBOutlet UIButton *edit_nameButton;
@property (weak, nonatomic) IBOutlet UIButton *editDOBButton;
@property (weak, nonatomic) IBOutlet UIButton *editDPButton;
@property (weak, nonatomic) IBOutlet UIButton *edit_amountPaidButton;
@property (weak, nonatomic) IBOutlet UIButton *edit_amountSoldButton;
@property (weak, nonatomic) IBOutlet UIButton *update_weightButton;
@property (weak, nonatomic) IBOutlet UIButton *add_vaccButton;
@property (weak, nonatomic) IBOutlet UIButton *update_commentButton;


@property (weak, nonatomic) IBOutlet UIButton *removeCowButton;



//Text Fields
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *datePurchasedTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountPaidTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountSoldTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *vaccinationTextField;

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;



@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;









@end
