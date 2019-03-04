//
//  ExpensesTableViewCell.m
//  Cow App
//
//  Created by Eric Rhodes on 2/26/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "ExpensesTableViewCell.h"

@implementation ExpensesTableViewCell


//When the view loads
-(void)viewDidLoad
{
    
    _descriptionTextView.layer.cornerRadius = 5.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
