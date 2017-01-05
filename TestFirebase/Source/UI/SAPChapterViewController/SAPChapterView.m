//
//  SAPChapterView.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterView.h"

#import "SAPChapter.h"

@implementation SAPChapterView

#pragma mark -
#pragma mark Accessors

- (void)setModel:(SAPChapter *)model {
    _model = model;
    [self fillWitModel];
}

- (void)fillWitModel {
    self.nameTextField.text = self.model.name;
    self.descriptionTextView.text = self.model.chapterDescription;
}

@end
