//
//  SAPChapterImagesViewController.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapterImagesViewController.h"

#import <Photos/Photos.h>
#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseStorage/FirebaseStorage.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SAPImage.h"
#import "SAPChapterImagesView.h"

#import "SAPViewControllerMacro.h"
#import "SAPConstants.h"

SAPViewControllerBaseViewProperty(SAPChapterImagesViewController, SAPChapterImagesView, mainView);

@interface SAPChapterImagesViewController ()
<
    UIPopoverPresentationControllerDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate
>

@property (nonatomic, assign) FIRDatabaseHandle addImageHandle;

@property (nonatomic, strong) UIBarButtonItem *addImageButton;
@property (nonatomic, strong) FIRStorageReference *storageReference;


@end

@implementation SAPChapterImagesViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[self.chapter.reference child:kSAPImages] removeObserverWithHandle:self.addImageHandle];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.chapter.name;
    
    [self setupNavigationItem];
    [self configureStorage];
    [self setupAddImageHandle];
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

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    NSURL *referenceURL = info[UIImagePickerControllerReferenceURL];
    // if it's a photo from the library, not an image from the camera
    if (referenceURL) {
        PHFetchResult* assets = [PHAsset fetchAssetsWithALAssetURLs:@[referenceURL] options:nil];
        PHAsset *asset = [assets firstObject];
        [asset requestContentEditingInputWithOptions:nil
                                   completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
                                       NSURL *imageFile = contentEditingInput.fullSizeImageURL;
                                       NSString *filePath = [NSString stringWithFormat:@"%lld/%@",
                                                             (long long)([[NSDate date] timeIntervalSince1970] * 1000.0),
                                                             [referenceURL lastPathComponent]];
                                       [[self.storageReference child:filePath] putFile:imageFile
                                                                              metadata:nil
                                                                            completion:^(FIRStorageMetadata *metadata, NSError *error)
                                       {
                                           if (error) {
                                               NSLog(@"Error uploading: %@", error);
                                               
                                               return;
                                           }
                                           
                                           SAPImage *image = [SAPImage new];
                                           image.chapterReference = self.chapter.reference;
                                           image.name = [referenceURL lastPathComponent];
                                           image.date = @"";
                                           image.imageURL = [self.storageReference child:metadata.path].description;
                                           [image addToDatabase];
                                       }];
                                   }];
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
#pragma mark Private

- (void)setupNavigationItem {
    UIBarButtonItem *addImageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                    target:self
                                                                                    action:@selector(onAddImage)];
    self.addImageButton = addImageButton;
    self.navigationItem.rightBarButtonItem = addImageButton;
}

- (void)configureStorage {
    NSString *storageUrl = [FIRApp defaultApp].options.storageBucket;
    self.storageReference = [[FIRStorage storage] referenceForURL:[NSString stringWithFormat:@"gs://%@", storageUrl]];
}

- (void)setupAddImageHandle {
    self.addImageHandle = [[self.chapter.reference child:kSAPImages] observeEventType:FIRDataEventTypeChildAdded
                                                                    withBlock:^(FIRDataSnapshot *snapshot)
                           {
                               [self.mainView.collectionView reloadData];
                           }];
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
