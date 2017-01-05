//
//  SAPImageCell.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "SAPImageCell.h"

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
#pragma mark SAPImageDelegate

- (void)delegatingSAPImage:(SAPImage *)delegatingObject imageDidLoad:(UIImage *)image {
    self.imageView.image = image;
}

#pragma mark -
#pragma makr Actions

- (IBAction)onDeleteButton:(UIButton *)sender {
    [self.model removeFromDatabase];
}

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(SAPImage *)model {
    model.delegate = self;
    if (model.image) {
        self.imageView.image = model.image;
    } else {
        [model loadImage];
    }
    
    self.nameLabel.text = model.name;
    self.dateLabel.text = model.date;
}

@end
