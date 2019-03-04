//
//  manageCowsTableViewCell.m
//  Cow App
//
//  Created by Eric Rhodes on 2/20/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "manageCowsTableViewCell.h"

@implementation manageCowsTableViewCell


-(void)viewDidLoad
{
    _vaccinations.layer.cornerRadius = 5.0;
    _information.layer.cornerRadius = 5.0;
    
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
