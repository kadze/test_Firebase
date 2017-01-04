//
//  SAPChapterCell.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPTableViewCell.h"

@class SAPChapter;

@interface SAPChapterCell : SAPTableViewCell
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastDateLabel;

@property (nonatomic, strong) SAPChapter *model;

@end
