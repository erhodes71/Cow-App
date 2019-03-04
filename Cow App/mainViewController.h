//
//  mainViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 8/15/18.
//  Copyright © 2018 Eric Rhodes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *manageHerdButton;
@property (weak, nonatomic) IBOutlet UIButton *expensesButton;


//Lables to be loaded
@property (weak, nonatomic) IBOutlet UILabel *numberOfCowsLable;
@property (weak, nonatomic) IBOutlet UILabel *numberOfExpensesLable;
@property (weak, nonatomic) IBOutlet UILabel *monthlyBudgetLable;
@property (weak, nonatomic) IBOutlet UILabel *totalExpenseCostLable;
@property (weak, nonatomic) IBOutlet UILabel *availableSurplusLable;








@end
