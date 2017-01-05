//
//  SAPChaptersViewModel.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPViewModelDelegate.h"

@class SAPChapter;

@interface SAPChaptersViewModel : NSObject
@property (nonatomic, weak) id<SAPViewModelDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;

- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (SAPChapter *)chapterForIndexPath:(NSIndexPath *)indexPath;

@end
