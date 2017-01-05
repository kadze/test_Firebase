//
//  SAPChapterCellViewModel.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPViewModelDelegate.h"

#import "SAPChapter.h"

@interface SAPChapterCellViewModel : NSObject <SAPChapterDelegate>
@property (nonatomic, strong) SAPChapter *chapter;
@property (nonatomic, readonly) NSString *nameLabelText;
@property (nonatomic, readonly) NSString *lastDateLabelText;

@property (nonatomic, weak) id<SAPViewModelDelegate> delegate;

@end
