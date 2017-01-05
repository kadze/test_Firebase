//
//  SAPModel.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/NSObject.h>

@class FIRDataSnapshot;
@class FIRDatabaseReference;

@interface SAPModel : NSObject
@property (nonatomic, strong) FIRDatabaseReference *reference;

+ (instancetype)modelWithSnapshot:(FIRDataSnapshot *)snapshot;

//these methods should be overriden in subclasses
- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot;

- (NSDictionary *)dictionary;
- (void)addToDatabase;

@end
