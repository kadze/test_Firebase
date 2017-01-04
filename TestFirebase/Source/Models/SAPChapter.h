//
//  SAPChapter.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FIRDataSnapshot;
@class FIRDatabaseReference;

@interface SAPChapter : NSObject
@property (nonatomic, readonly) NSInteger imagesCount;

@property (nonatomic, copy, readonly) NSString *lastImageDate;

@property (nonatomic, strong) FIRDatabaseReference *reference;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *chapterDescription;

+ (instancetype)chapterWithSnapshot:(FIRDataSnapshot *)snapshot;

- (NSDictionary *)dictionary;
- (void)addToDatabase;

@end
