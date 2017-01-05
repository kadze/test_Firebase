//
//  SAPChaptersViewModel.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <FirebaseDatabase/FirebaseDatabase.h>
#import <UIKit/UITableView.h>

#import "SAPChaptersViewModel.h"
#import "SAPChapterCellViewModel.h"

#import "SAPChapter.h"
#import "SAPChapterCell.h"

#import "SAPConstants.h"
#import "SAPOwnershipMacro.h"

static CGFloat const kSAPRowHeight = 66.0;

@interface SAPChaptersViewModel ()
@property (nonatomic, assign) FIRDatabaseHandle addChapterHandle;

@property (nonatomic, strong) NSMutableArray<SAPChapter *>  *chapters;
@property (nonatomic, strong) FIRDatabaseReference          *databaseReference;

@end

@implementation SAPChaptersViewModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[self.databaseReference child:kSAPChapters] removeObserverWithHandle:self.addChapterHandle];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.chapters = [NSMutableArray new];
    [self configureDatabase];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.chapters.count;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SAPChapterCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[SAPChapterCell reuseIdentifier]];
    SAPChapterCellViewModel *viewModel = [SAPChapterCellViewModel new];
    viewModel.chapter = self.chapters[indexPath.row];
    cell.viewModel = viewModel;
    
    return cell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSAPRowHeight;
}

- (SAPChapter *)chapterForIndexPath:(NSIndexPath *)indexPath {
    return self.chapters[indexPath.row];
}

#pragma mark -
#pragma mark Private

- (void)configureDatabase {
    self.databaseReference = [[FIRDatabase database] reference];
    SAPWeakify(self);
    self.addChapterHandle = [[self.databaseReference child:kSAPChapters] observeEventType:FIRDataEventTypeChildAdded
                                                                                withBlock:^(FIRDataSnapshot *snapshot)
                             {
                                 SAPStrongify(self);
                                 [self.chapters addObject:[SAPChapter modelWithSnapshot:snapshot]];
                                 [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.chapters.count - 1 inSection:0]]
                                                       withRowAnimation: UITableViewRowAnimationAutomatic];
                             }];
}

@end
