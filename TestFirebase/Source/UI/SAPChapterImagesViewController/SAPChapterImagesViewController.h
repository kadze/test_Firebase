//
//  SAPChapterImagesViewController.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPImageSelectionMenuViewController.h"
#import "SAPViewModelDelegate.h"

@class SAPChapter;

@interface SAPChapterImagesViewController : UIViewController
<
    SAPImageSelectionMenuViewControllerDelegate,
    SAPViewModelDelegate
>

@property (nonatomic, strong) SAPChapter *chapter;

@end
