//
//  SAPCollectionViewCell.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <UIKit/UINib.h>
#import <UIKit/UICollectionViewCell.h>

//You should never expect the cell to have the reuseIdentifier you passed during initialization
@interface SAPCollectionViewCell : UICollectionViewCell

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;

@end
