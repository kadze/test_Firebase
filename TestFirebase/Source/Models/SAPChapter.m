//
//  SAPChapter.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPChapter.h"

#import <FirebaseDatabase/FirebaseDatabase.h>

#import "SAPConstants.h"
#import "SAPImage.h"

@interface SAPChapter ()
//@property (nonatomic, strong) FIRDatabaseReference *databaseReference;
@property (nonatomic, assign) FIRDatabaseHandle addImageHandle;
@property (nonatomic, assign) FIRDatabaseHandle removeImageHandle;
@property (nonatomic, strong) NSMutableArray<SAPImage *> *mutableImages;

@end

@implementation SAPChapter
@dynamic images;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)chapterWithSnapshot:(FIRDataSnapshot *)snapshot {
    return [[self alloc] initWithSnapshot:snapshot];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
     [[self.reference child:kSAPImages] removeObserverWithHandle:self.addImageHandle];
    [[self.reference child:kSAPImages] removeObserverWithHandle:self.removeImageHandle];
}

- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.mutableImages = [NSMutableArray new];
    self.uid = snapshot.key;
    self.reference = snapshot.ref;
    NSDictionary<NSString *, NSString *> *chapterDictionary = snapshot.value;
    self.name = chapterDictionary[@"name"];
    self.chapterDescription = chapterDictionary[@"description"];
    
    [self setupImageHandles];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)images {
    return [_mutableImages copy];
}

- (NSInteger)imagesCount {
    return _mutableImages.count;
}

#pragma mark -
#pragma mark Public

- (NSDictionary *)dictionary {
    return @{@"name" : self.name,
             @"description" : self.chapterDescription};
}

- (void)addToDatabase {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    [[[databaseReference child:kSAPChapters] childByAutoId] setValue:[self dictionary]];
}

- (void)setupImageHandles {
    self.addImageHandle = [[self.reference child:kSAPImages] observeEventType:FIRDataEventTypeChildAdded
                                                                    withBlock:^(FIRDataSnapshot *snapshot)
                           {
                               [self.mutableImages addObject:[SAPImage imageWithSnapshot:snapshot]];
                           }];
    
    self.removeImageHandle = [[self.reference child:kSAPImages] observeEventType:FIRDataEventTypeChildRemoved
                                                                       withBlock:^(FIRDataSnapshot *snapshot)
                              {
                                  [self.mutableImages removeObject:[SAPImage imageWithSnapshot:snapshot]];
                              }];
}

@end
