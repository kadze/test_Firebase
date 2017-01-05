//
//  SAPChapterImagesViewModel.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPChapter.h"
#import "SAPViewModelDelegate.h"

@interface SAPChapterImagesViewModel : NSObject <SAPChapterDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) SAPChapter        *chapter;
@property (nonatomic, strong) UICollectionView  *collectionView;

@property (nonatomic, readonly) NSString *imagesCountLabelText;
@property (nonatomic, readonly) NSString *lastImageNameLabelText;
@property (nonatomic, readonly) NSString *lastImageDateLabelText;

@property (nonatomic, weak) id<SAPViewModelDelegate> delegate;

- (void)addImageToDatabaseWithReferenceURL:(NSURL *)referenceURL;

@end
