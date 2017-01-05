//
//  SAPTableViewCell.h
//  IOSProject
//
//  Created by S A P on 2/7/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <UIKit/UINib.h>
#import <UIKit/UITableViewCell.h>


//You should never expect the cell to have the reuseIdentifier you passed during initialization
@interface SAPTableViewCell : UITableViewCell

+ (UINib *)nib;
+ (NSString *)reuseIdentifier;

@end
