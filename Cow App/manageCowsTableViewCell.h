//
//  manageCowsTableViewCell.h
//  Cow App
//
//  Created by Eric Rhodes on 2/20/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface manageCowsTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *cowName;

@property (weak, nonatomic) IBOutlet UILabel *weight;


@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;
@property (weak, nonatomic) IBOutlet UILabel *datePurchased;

@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UILabel *weightTimeLine;
@property (weak, nonatomic) IBOutlet UILabel *amountPaid;
@property (weak, nonatomic) IBOutlet UILabel *weightBought;
@property (weak, nonatomic) IBOutlet UILabel *amountSold;

@property (weak, nonatomic) IBOutlet UILabel *weightSold;

@property (weak, nonatomic) IBOutlet UITextView *vaccinations;


@property (weak, nonatomic) IBOutlet UILabel *parent1;
@property (weak, nonatomic) IBOutlet UILabel *parent2;
@property (weak, nonatomic) IBOutlet UILabel *owned;
@property (weak, nonatomic) IBOutlet UILabel *isAlive;
@property (weak, nonatomic) IBOutlet UILabel *isRegistered;
@property (weak, nonatomic) IBOutlet UILabel *boughtFrom;
@property (weak, nonatomic) IBOutlet UILabel *soldTo;

@property (weak, nonatomic) IBOutlet UITextView *information;











@end
