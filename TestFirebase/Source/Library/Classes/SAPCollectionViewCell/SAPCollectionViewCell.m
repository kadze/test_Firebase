//
//  SAPCollectionViewCell.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPCollectionViewCell.h"

#import "UINib+SAPExtensions.h"

@implementation SAPCollectionViewCell

#pragma mark -
#pragma mark Class Methods

+ (UINib *)nib {
    return [UINib nibWithNibName:[self reuseIdentifier] bundle:nil];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

#pragma mark-
#pragma mark Accessors

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
