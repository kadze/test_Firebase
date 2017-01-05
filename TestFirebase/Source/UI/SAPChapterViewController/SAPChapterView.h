//
//  SAPChapterView.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPChapter;

@interface SAPChapterView : UIView
@property (nonatomic, strong) IBOutlet UITextField   *nameTextField;
@property (nonatomic, strong) IBOutlet UITextView    *descriptionTextView;

@property (nonatomic, strong) SAPChapter *model;

@end
