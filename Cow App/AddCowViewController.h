//
//  AddCowViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/24/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *trueButton;
@property (weak, nonatomic) IBOutlet UIButton *falseButton;



@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *datePurchasedTextField;
@property (weak, nonatomic) IBOutlet UITextField *amountPaidTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *vaccinationTextField;
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *parent1TextField;
@property (weak, nonatomic) IBOutlet UITextField *parent2TextField;
@property (weak, nonatomic) IBOutlet UITextField *boughtFromTextField;

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;








@end
