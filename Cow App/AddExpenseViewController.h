//
//  AddExpenseViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/26/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddExpenseViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;




@end
