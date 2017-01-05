//
//  SAPChapterCellViewModel.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterCellViewModel.h"

@implementation SAPChapterCellViewModel

#pragma mark -
#pragma mark Accessors

- (NSString *)nameLabelText {
    return self.chapter.name;
}

- (NSString *)lastDateLabelText {
    return [NSString stringWithFormat:@"Last: %@", self.chapter.lastImageDate ? :@""];
}

- (void)setChapter:(SAPChapter *)chapter {
    _chapter = chapter;
    chapter.delegate = self;
}

#pragma mark -
#pragma mark SAPChapterDelegate

- (void)chapterDidCnahge:(SAPChapter *)chapter {
    [self.delegate viewModelDidChange:self];
}

@end
