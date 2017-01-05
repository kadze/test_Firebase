//
//  SAPModel.m
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPModel.h"

@implementation SAPModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithSnapshot:(FIRDataSnapshot *)snapshot {
    return [[self alloc] initWithSnapshot:snapshot];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSDictionary *)dictionary {
    return nil;
}

- (void)addToDatabase {
    
}

@end
