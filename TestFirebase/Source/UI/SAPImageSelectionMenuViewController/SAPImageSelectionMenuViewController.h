//
//  SAPImageSelectionMenuViewController.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPImageSelectionMenuViewController;

@protocol SAPImageSelectionMenuViewControllerDelegate <NSObject>

- (void)imageSelectionMenuController:(SAPImageSelectionMenuViewController *)controller onChoosePhoto:(UIButton *)button;
- (void)imageSelectionMenuController:(SAPImageSelectionMenuViewController *)controller onMakePhoto:(UIButton *)button;

@end

@interface SAPImageSelectionMenuViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIButton *choosePhotoButton;
@property (nonatomic, strong) IBOutlet UIButton *makePhotoButton;

@property (nonatomic, weak) id<SAPImageSelectionMenuViewControllerDelegate> delegate;

- (IBAction)onChoosePhoto:(UIButton *)sender;
- (IBAction)onMakePhoto:(UIButton *)sender;

@end
