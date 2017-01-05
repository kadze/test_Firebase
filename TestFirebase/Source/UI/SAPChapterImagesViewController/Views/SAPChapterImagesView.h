//
//  SAPChapterImagesView.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAPChapterImagesViewModel;

@interface SAPChapterImagesView : UIView
@property (nonatomic, strong) IBOutlet UIView *chapterInfoView;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) IBOutlet UILabel *imagesCountLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastTitleLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastImageNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *lastImageDateLabel;

- (void)fillWithViewModel:(SAPChapterImagesViewModel *)viewModel;

@end
