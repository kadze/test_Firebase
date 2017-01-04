//
//  SAPChapterViewController.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterViewController.h"

static NSString * const kSAPTitle = @"Add";

@interface SAPChapterViewController ()

@end

@implementation SAPChapterViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kSAPTitle;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setupNavigationItem];
}

#pragma mark -
#pragma mark Actions

- (void)save {
    
}

#pragma mark -
#pragma mark Private

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(save)];
}

@end
