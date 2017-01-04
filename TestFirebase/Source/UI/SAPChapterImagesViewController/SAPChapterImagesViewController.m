//
//  SAPChapterImagesViewController.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterImagesViewController.h"

@interface SAPChapterImagesViewController ()
<
    UIPopoverPresentationControllerDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (nonatomic, strong) UIBarButtonItem *addImageButton;

@end

@implementation SAPChapterImagesViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.chapter.name;
    
    [self setupNavigationItem];
}

#pragma mark -
#pragma mark UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark -
#pragma mark SAPImageSelectionMenuViewControllerDelegate

- (void)imageSelectionMenuController:(SAPImageSelectionMenuViewController *)controller onChoosePhoto:(UIButton *)button {
    [self presentImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imageSelectionMenuController:(SAPImageSelectionMenuViewController *)controller onMakePhoto:(UIButton *)button {
    [self presentImagePickerForSourceType:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate



#pragma mark -
#pragma mark Private

- (void)setupNavigationItem {
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                    target:self
                                                                                    action:@selector(onAddImage)];
    self.addImageButton = addImageButton;
    self.navigationItem.rightBarButtonItem = addImageButton;
}

- (void)onAddImage {
    SAPImageSelectionMenuViewController *menuController = [SAPImageSelectionMenuViewController new];
    menuController.delegate = self;
    menuController.modalPresentationStyle = UIModalPresentationPopover;
    menuController.popoverPresentationController.delegate = self;
    menuController.popoverPresentationController.barButtonItem = self.addImageButton;
    [self presentViewController:menuController animated:YES completion:nil];
}

- (void)presentImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        picker.sourceType = sourceType;
        [self dismissViewControllerAnimated:NO completion:^{
            [self presentViewController:picker animated:YES completion:NULL];
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
