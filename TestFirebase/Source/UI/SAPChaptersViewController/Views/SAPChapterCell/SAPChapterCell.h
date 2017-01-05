//
//  SAPChapterCell.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPTableViewCell.h"

#import "SAPViewModelDelegate.h"

@class SAPChapterCellViewModel;
@class SAPChapterCell;

@protocol SAPChapterCellDelegate <NSObject>

- (void)chapterCell:(SAPChapterCell *)cell onEditButton:(UIButton *)button;

@end
@interface SAPChapterCell : SAPTableViewCell <SAPViewModelDelegate>
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastDateLabel;

@property (nonatomic, strong) SAPChapterCellViewModel *viewModel;

@property (nonatomic, weak) id<SAPChapterCellDelegate> delegate;

@end
