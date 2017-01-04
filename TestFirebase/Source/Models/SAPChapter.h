//
//  SAPChapter.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FIRDataSnapshot;

@interface SAPChapter : NSObject
@property (nonatomic, readonly) NSInteger imagesCount;

@property (nonatomic, copy, readonly) NSString *lastImageDate;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *chapterDescription;

+ (instancetype)chapterWithSnapshot:(FIRDataSnapshot *)snapshot;

- (NSDictionary *)dictionary;

@end
