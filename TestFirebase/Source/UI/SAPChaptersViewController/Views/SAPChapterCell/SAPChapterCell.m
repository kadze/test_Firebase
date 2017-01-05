//
//  SAPChapterCell.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterCell.h"

#import "SAPChapterCellViewModel.h"

@implementation SAPChapterCell

#pragma mark -
#pragma mark Accessors

- (void)setViewModel:(SAPChapterCellViewModel *)viewModel {
    _viewModel = viewModel;
    viewModel.delegate = self;
    [self fillWithViewModel];
}

- (void)fillWithViewModel {
    self.nameLabel.text = self.viewModel.nameLabelText;
    self.lastDateLabel.text = self.viewModel.lastDateLabelText;
}

#pragma mark -
#pragma mark SAPViewModelDelegate

- (void)viewModelDidChange:(id)viewModel {
    [self fillWithViewModel];
}

#pragma mark -
#pragma mark Actions

- (IBAction)onEditButton:(UIButton *)sender {
    [self.delegate chapterCell:self onEditButton:sender];
}

@end
