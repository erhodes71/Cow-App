//
//  ManageCowsViewController.h
//  Cow App
//
//  Created by Eric Rhodes on 2/20/19.
//  Copyright © 2019 Eric Rhodes. All rights reserved.
//

#import "ViewController.h"


@interface ManageCowsViewController : ViewController <UITableViewDelegate, UITableViewDataSource>


//Table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end
