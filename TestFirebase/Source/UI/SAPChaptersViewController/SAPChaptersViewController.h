//
//  SAPChaptersViewController.h
//  TestFirebase
//
//  Created by ASH on 1/3/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPViewModelDelegate.h"

@interface SAPChaptersViewController : UIViewController <SAPViewModelDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
