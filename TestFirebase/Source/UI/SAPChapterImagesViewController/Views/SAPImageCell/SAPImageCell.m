//
//  SAPImageCell.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "SAPImageCell.h"
#import "SAPImage.h"

@implementation SAPImageCell

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPImage *)model {
    if (_model != model) {
        _model = model;
        
        [self fillWithModel:model];
    }
}

#pragma mark -
#pragma mark SAPModelView

- (void)fillWithModel:(SAPImage *)model {
    self.imageView.image = model.image;
    self.nameLabel.text = model.name;
    self.dateLabel.text = model.date;
}

@end
