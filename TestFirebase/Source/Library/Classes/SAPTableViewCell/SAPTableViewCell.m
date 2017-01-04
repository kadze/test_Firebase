//
//  SAPTableViewCell.m
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import "SAPTableViewCell.h"

#import "UINib+SAPExtensions.h"

@implementation SAPTableViewCell

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
