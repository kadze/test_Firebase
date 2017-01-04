//
//  SAPChaptersViewController.m
//  TestFirebase
//
//  Created by ASH on 1/3/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChaptersViewController.h"

#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SAPChapter.h"
#import "SAPChapterViewController.h"
#import "SAPChapterCell.h"
#import "SAPChapterImagesViewController.h"

#import "SAPConstants.h"

static NSString * const kSAPTitle = @"Metra";

@interface SAPChaptersViewController () <UITableViewDataSource, UITabBarDelegate>
@property (nonatomic, assign) FIRDatabaseHandle addChapterHandle;

@property (nonatomic, strong) FIRDatabaseReference          *databaseReference;
@property (nonatomic, strong) NSMutableArray<SAPChapter *>  *chapters;

@end

@implementation SAPChaptersViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[self.databaseReference child:kSAPChapters] removeObserverWithHandle:self.addChapterHandle];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chapters = [NSMutableArray new];
    
    self.title = kSAPTitle;
    [self setupNavigationItem];
    [self setupTableView];
    
    [self configureDatabase];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:[SAPChapterCell reuseIdentifier]];
    cell.model = self.chapters[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPChapterImagesViewController *imagesController = [SAPChapterImagesViewController new];
    imagesController.chapter = self.chapters[indexPath.row];
    [self.navigationController pushViewController:imagesController animated:YES];
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

- (void)configureDatabase {
    self.databaseReference = [[FIRDatabase database] reference];
    self.addChapterHandle = [[self.databaseReference child:kSAPChapters] observeEventType:FIRDataEventTypeChildAdded
                                                             withBlock:^(FIRDataSnapshot *snapshot) {
        [self.chapters addObject:[SAPChapter chapterWithSnapshot:snapshot]];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.chapters.count - 1 inSection:0]]
                          withRowAnimation: UITableViewRowAnimationAutomatic];
                                                             }];
}

- (void)setupTableView {
    [self.tableView registerNib:[SAPChapterCell nib] forCellReuseIdentifier:[SAPChapterCell reuseIdentifier]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

@end
