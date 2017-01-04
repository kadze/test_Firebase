//
//  SAPChapterImagesViewController.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SAPChapter.h"

#import "SAPImageSelectionMenuViewController.h"

@interface SAPChapterImagesViewController : UIViewController <SAPImageSelectionMenuViewControllerDelegate>
@property (nonatomic, strong) SAPChapter *chapter;

@end
