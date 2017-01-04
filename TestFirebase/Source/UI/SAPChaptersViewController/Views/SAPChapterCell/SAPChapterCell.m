//
//  SAPChapterCell.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterCell.h"

#import "SAPChapter.h"

@implementation SAPChapterCell

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPChapter *)model {
    _model = model;
    [self fillWithModel];
}

- (void)fillWithModel {
    self.nameLabel.text = self.model.name;
    self.lastDateLabel.text = self.model.last.description;/// remake with viewmodel
}

@end
