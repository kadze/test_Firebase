//
//  SAPChapter.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapter.h"

#import <FirebaseDatabase/FirebaseDatabase.h>

@implementation SAPChapter

#pragma mark -
#pragma mark Class Methods

+ (instancetype)chapterWithSnapshot:(FIRDataSnapshot *)snapshot {
    return [[self alloc] initWithSnapshot:snapshot];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSDictionary<NSString *, NSString *> *chapterDictionary = snapshot.value;
    self.name = chapterDictionary[@"name"];
    self.chapterDescription = chapterDictionary[@"description"];
    
    return self;
}

@end
