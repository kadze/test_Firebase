//
//  SAPChapterImagesViewModel.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SAPChapterImagesViewModel.h"
#import "SAPImage.h"
#import "SAPImageCell.h"

#import "SAPConstants.h"

@interface SAPChapterImagesViewModel ()
@property (nonatomic, assign) FIRDatabaseHandle addImageHandle;
@property (nonatomic, assign) FIRDatabaseHandle removeImageHandle;

@end

@implementation SAPChapterImagesViewModel

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[self.chapter.reference child:kSAPImages] removeObserverWithHandle:self.addImageHandle];
    [[self.chapter.reference child:kSAPImages] removeObserverWithHandle:self.removeImageHandle];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)imagesCountLabelText {
    return [NSString stringWithFormat:@"Overall: %ld", (long)self.chapter.imagesCount];
}

- (NSString *)lastImageNameLabelText {
    return [NSString stringWithFormat:@"Name: %@", self.chapter.lastImageName ? :@""];
}

- (NSString *)lastImageDateLabelText {
    return [NSString stringWithFormat:@"Date: %@", self.chapter.lastImageDate ? :@""];
}

- (void)setCollectionView:(UICollectionView *)collectionView {
    _collectionView = collectionView;
    collectionView.dataSource = self;
}

- (void)setChapter:(SAPChapter *)chapter {
    _chapter = chapter;
    [self setupImageHandles];
}

#pragma mark -
#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chapter.imagesCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SAPImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SAPImageCell reuseIdentifier]
                                                                   forIndexPath:indexPath];
    cell.model = self.chapter.images[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark Public

- (void)addImageToDatabaseWithReferenceURL:(NSURL *)referenceURL {
    SAPImage *image = [SAPImage imageWithImagePickerReferenceURL:referenceURL chapterReference:self.chapter.reference];
    [image addToDatabase];
}

#pragma mark -
#pragma mark SAPChapterDelegate

- (void)chapterDidCnahge:(SAPChapter *)chapter {
    [self.delegate viewModelDidChange:self];
}

#pragma mark -
#pragma mark Private

- (void)setupImageHandles {
    self.addImageHandle = [[self.chapter.reference child:kSAPImages] observeEventType:FIRDataEventTypeChildAdded
                                                                            withBlock:^(FIRDataSnapshot *snapshot)
                           {
                               [self.collectionView reloadData];
                               [self.delegate viewModelDidChange:self];
                           }];
    
    self.removeImageHandle = [[self.chapter.reference child:kSAPImages] observeEventType:FIRDataEventTypeChildRemoved
                                                                               withBlock:^(FIRDataSnapshot *snapshot)
                              {
                                  [self.collectionView reloadData];
                                  [self.delegate viewModelDidChange:self];
                              }];
}

@end
