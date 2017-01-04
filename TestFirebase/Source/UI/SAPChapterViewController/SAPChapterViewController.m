//
//  SAPChapterViewController.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterViewController.h"

#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SAPChapter.h"
#import "SAPChapterView.h"

#import "SAPViewControllerMacro.h"
#import "SAPConstants.h"

static NSString * const kSAPTitle = @"Add";

SAPViewControllerBaseViewProperty(SAPChapterViewController, SAPChapterView, mainView);

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
    SAPChapter *chapter = self.model;
    SAPChapterView *view = self.mainView;
    chapter.name = view.nameTextField.text;
    chapter.chapterDescription = view.descriptionTextView.text;
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    [[[databaseReference child:kSAPChapters] childByAutoId] setValue:[chapter dictionary]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Private

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                           target:self
                                                                                           action:@selector(save)];
}

@end
