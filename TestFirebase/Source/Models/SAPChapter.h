//
//  SAPChapter.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPModel.h"

@class FIRDataSnapshot;
@class FIRDatabaseReference;
@class SAPImage;

@interface SAPChapter : SAPModel
@property (nonatomic, readonly) NSInteger imagesCount;

@property (nonatomic, copy, readonly) NSString              *lastImageDate;
@property (nonatomic, readonly)       NSArray<SAPImage *>   *images;

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *chapterDescription;

@end
