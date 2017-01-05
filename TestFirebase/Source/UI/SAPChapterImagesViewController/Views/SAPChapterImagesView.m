//
//  SAPChapterImagesView.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterImagesView.h"

#import "SAPChapterImagesViewModel.h"

@implementation SAPChapterImagesView

#pragma mark -
#pragma mark Public

- (void)fillWithViewModel:(SAPChapterImagesViewModel *)viewModel {
    self.imagesCountLabel.text = viewModel.imagesCountLabelText;
    self.lastImageNameLabel.text = viewModel.lastImageNameLabelText;
    self.lastImageDateLabel.text = viewModel.lastImageDateLabelText;
}

@end
