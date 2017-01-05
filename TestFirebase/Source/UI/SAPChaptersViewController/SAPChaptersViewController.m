//
//  SAPChaptersViewController.m
//  TestFirebase
//
//  Created by ASH on 1/3/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChaptersViewController.h"

#import "SAPChapter.h"
#import "SAPChapterViewController.h"
#import "SAPChapterCell.h"
#import "SAPChapterImagesViewController.h"
#import "SAPChaptersViewModel.h"

#import "SAPConstants.h"

static NSString * const kSAPTitle = @"Metra";

@interface SAPChaptersViewController () <UITableViewDataSource, UITabBarDelegate>
@property (nonatomic, strong) SAPChaptersViewModel *viewModel;

@end

@implementation SAPChaptersViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SAPChaptersViewModel *viewModel = [SAPChaptersViewModel new];
    viewModel.delegate = self;
    viewModel.tableView = self.tableView;
    self.viewModel = viewModel;
    
    self.title = kSAPTitle;
    [self setupNavigationItem];
    [self setupTableView];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPChapterImagesViewController *imagesController = [SAPChapterImagesViewController new];
    imagesController.chapter = [self.viewModel chapterForIndexPath:indexPath];
    [self.navigationController pushViewController:imagesController animated:YES];
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark SAPViewModelDelegate

- (void)viewModelDidChange:(id)viewModel {
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Actions

- (void)addChapter {
    SAPChapterViewController *chapterController = [SAPChapterViewController new];
    chapterController.model = [SAPChapter new];
    [self.navigationController pushViewController:chapterController animated:YES];
}

#pragma mark -
#pragma mark Private

- (void)setupNavigationItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self
                                                                                           action:@selector(addChapter)];
}

- (void)setupTableView {
    [self.tableView registerNib:[SAPChapterCell nib] forCellReuseIdentifier:[SAPChapterCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}



@end
