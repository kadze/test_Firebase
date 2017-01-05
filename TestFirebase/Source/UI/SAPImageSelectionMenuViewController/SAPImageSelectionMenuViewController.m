//
//  SAPImageSelectionMenuViewController.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPImageSelectionMenuViewController.h"

@implementation SAPImageSelectionMenuViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.preferredContentSize = [self.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
}

#pragma mark -
#pragma mark Actions

- (IBAction)onChoosePhoto:(UIButton *)sender {
    [self.delegate imageSelectionMenuController:self onChoosePhoto:sender];
}

- (IBAction)onMakePhoto:(UIButton *)sender {
    [self.delegate imageSelectionMenuController:self onMakePhoto:sender];
}

@end
