//
//  SAPImage.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FIRDataSnapshot;
@class FIRDatabaseReference;
@class UIImage;

@interface SAPImage : NSObject

@property (nonatomic, strong) FIRDatabaseReference *reference;
@property (nonatomic, strong) FIRDatabaseReference *chapterReference;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)imageWithSnapshot:(FIRDataSnapshot *)snapshot;

- (NSDictionary *)dictionary;
- (void)addToDatabase;

@end
