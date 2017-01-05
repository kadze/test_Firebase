//
//  SAPImageCell.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPCollectionViewCell.h"
#import "SAPImage.h"

@interface SAPImageCell : SAPCollectionViewCell <SAPImageDelegate>
@property (nonatomic, strong) IBOutlet UIImageView  *imageView;
@property (nonatomic, strong) IBOutlet UILabel      *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel      *dateLabel;
@property (nonatomic, strong) IBOutlet UIButton     *deleteButton;

@property (nonatomic, strong) SAPImage *model;

@end
