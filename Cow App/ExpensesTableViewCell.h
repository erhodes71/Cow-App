//
//  ExpensesTableViewCell.h
//  Cow App
//
//  Created by Eric Rhodes on 2/26/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpensesTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet UILabel *costLable;






@end
