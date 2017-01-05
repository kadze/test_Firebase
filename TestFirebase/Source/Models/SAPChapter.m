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
@property (nonatomic, assign) FIRDatabaseHandle addImageHandle;
@property (nonatomic, assign) FIRDatabaseHandle removeImageHandle;
@property (nonatomic, strong) NSMutableArray<SAPImage *>    *mutableImages;
@property (nonatomic, copy)   NSString                      *lastImageDate;
@property (nonatomic, copy)   NSString                      *lastImageName;

@end

@implementation SAPChapter
@dynamic images;
@synthesize reference = _reference;

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
                               SAPImage *image = [SAPImage modelWithSnapshot:snapshot];
                               [self.mutableImages addObject:image];
                               self.lastImageDate = image.date;
                               self.lastImageName = image.name;
                               [self.delegate chapterDidCnahge:self];
                           }];
    
    self.removeImageHandle = [[self.reference child:kSAPImages] observeEventType:FIRDataEventTypeChildRemoved
                                                                       withBlock:^(FIRDataSnapshot *snapshot)
                              {
                                  [self.mutableImages removeObject:[SAPImage modelWithSnapshot:snapshot]];
                                  SAPImage *lastImage = self.images.lastObject;
                                  self.lastImageDate = lastImage.date;
                                  self.lastImageName = lastImage.name;
                                  [self.delegate chapterDidCnahge:self];
                              }];
}

@end
