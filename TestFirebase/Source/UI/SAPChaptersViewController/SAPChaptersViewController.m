//
//  SAPChaptersViewController.m
//  TestFirebase
//
//  Created by ASH on 1/3/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChaptersViewController.h"

static NSString * const kSAPTitle = @"Metra";

@interface SAPChaptersViewController ()

@end

@implementation SAPChaptersViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kSAPTitle;
    [self setupNavigationItem];
}

#pragma mark -
#pragma mark Actions

- (void)addChapter {
    
}

#pragma mark -
#pragma mark Private

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addChapter)];
}

@end
