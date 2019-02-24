//
//  MoreInfoViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/23/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreInfoViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;



@property (weak, nonatomic) IBOutlet UIButton *edit_brandButton;
@property (weak, nonatomic) IBOutlet UIButton *edit_weightBoughtButton;
@property (weak, nonatomic) IBOutlet UIButton *edit_weightSoldButton;
@property (weak, nonatomic) IBOutlet UIButton *edit_parent1Button;
@property (weak, nonatomic) IBOutlet UIButton *edit_parent2Button;
@property (weak, nonatomic) IBOutlet UIButton *edit_boughtFromButton;
@property (weak, nonatomic) IBOutlet UIButton *edit_soldToButton;

@property (weak, nonatomic) IBOutlet UIButton *true_ownedButton;
@property (weak, nonatomic) IBOutlet UIButton *false_ownedButton;

@property (weak, nonatomic) IBOutlet UIButton *true_isAliveButton;
@property (weak, nonatomic) IBOutlet UIButton *false_isAliveButton;

@property (weak, nonatomic) IBOutlet UIButton *true_registaredButton;
@property (weak, nonatomic) IBOutlet UIButton *false_registaredButton;





//Text fields

@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightBoughtTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightSoldTextField;
@property (weak, nonatomic) IBOutlet UITextField *parent1TextField;
@property (weak, nonatomic) IBOutlet UITextField *parent2TextField;
@property (weak, nonatomic) IBOutlet UITextField *boughtFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *soldToTextField;




















@end
