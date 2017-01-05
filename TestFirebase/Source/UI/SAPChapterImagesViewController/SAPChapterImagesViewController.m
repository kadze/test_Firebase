//
//  SAPChapterImagesViewController.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterImagesViewController.h"

#import <Photos/Photos.h>
//#import <FirebaseCore/FirebaseCore.h>
//#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SAPChapterImagesViewModel.h"
#import "SAPImage.h"
#import "SAPChapter.h"
#import "SAPChapterImagesView.h"
#import "SAPImageCell.h"

#import "SAPViewControllerMacro.h"
#import "SAPConstants.h"
#import "SAPOwnershipMacro.h"

SAPViewControllerBaseViewProperty(SAPChapterImagesViewController, SAPChapterImagesView, mainView);

@interface SAPChapterImagesViewController ()
<
    UIPopoverPresentationControllerDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (nonatomic, strong) UIBarButtonItem *addImageButton;
@property (nonatomic, strong) SAPChapterImagesViewModel *viewModel;

@end

@implementation SAPChapterImagesViewController

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.chapter.name;
    
    [self setupNavigationItem];
    [self setupCollectionView];
    
    SAPChapterImagesViewModel *viewModel = [SAPChapterImagesViewModel new];
    viewModel.chapter = self.chapter;
    viewModel.delegate = self;
    viewModel.collectionView = self.mainView.collectionView;
    self.viewModel = viewModel;
    
    [self.mainView fillWithViewModel:viewModel];
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

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSURL *referenceURL = info[UIImagePickerControllerReferenceURL];
    
    // if it's a photo from the library, not an image from the camera
    if (referenceURL) {
        [self.viewModel addImageToDatabaseWithReferenceURL:referenceURL];

    } else {
//        UIImage *image = info[UIImagePickerControllerOriginalImage];
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
//        NSString *imagePath =
//        [NSString stringWithFormat:@"%@/%lld.jpg",
//         [FIRAuth auth].currentUser.uid,
//         (long long)([[NSDate date] timeIntervalSince1970] * 1000.0)];
//        FIRStorageMetadata *metadata = [FIRStorageMetadata new];
//        metadata.contentType = @"image/jpeg";
//        [[_storageRef child:imagePath] putData:imageData metadata:metadata
//                                    completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
//                                        if (error) {
//                                            NSLog(@"Error uploading: %@", error);
//                                            return;
//                                        }
//                                        [self sendMessage:@{MessageFieldsimageURL:[_storageRef child:metadata.path].description}];
//                                    }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark SAPViewModelDelegate

- (void)viewModelDidChange:(id)viewModel {
    [self.mainView fillWithViewModel:viewModel];
}

#pragma mark -
#pragma mark Private

- (void)setupNavigationItem {
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                    target:self
                                                                                    action:@selector(onAddImage)];
    self.addImageButton = addImageButton;
    self.navigationItem.rightBarButtonItem = addImageButton;
}

- (void)setupCollectionView {
    UICollectionView *collectionView = self.mainView.collectionView;
    [collectionView registerNib:[SAPImageCell nib] forCellWithReuseIdentifier:[SAPImageCell reuseIdentifier]];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    
    NSInteger cellsPerRow = 2;
    CGFloat marginsAndInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right + flowLayout.minimumInteritemSpacing * (cellsPerRow - 1);
    CGFloat itemWidth = (collectionView.bounds.size.width - marginsAndInsets) / cellsPerRow;
    
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
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
        SAPWeakify(self);
        [self dismissViewControllerAnimated:NO completion:^{
            SAPStrongify(self);
            [self presentViewController:picker animated:YES completion:NULL];
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
