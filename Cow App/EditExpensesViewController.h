//
//  EditExpensesViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/26/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditExpensesViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *costTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet UIButton *title_editButton;
@property (weak, nonatomic) IBOutlet UIButton *cost_editButton;
@property (weak, nonatomic) IBOutlet UIButton *description_editButton;

@property (weak, nonatomic) IBOutlet UIButton *removeButton;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;




@end
