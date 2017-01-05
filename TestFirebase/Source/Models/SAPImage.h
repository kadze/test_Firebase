//
//  SAPImage.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SAPModel.h"

@class FIRDataSnapshot;
@class FIRDatabaseReference;
@class UIImage;

@class SAPImage;

@protocol SAPImageDelegate <NSObject>

- (void)delegatingSAPImage:(SAPImage *)delegatingObject imageDidLoad:(UIImage *)image;

@end

@interface SAPImage : SAPModel

@property (nonatomic, strong) FIRDatabaseReference  *chapterReference;
@property (nonatomic, copy) NSString                *uid;
@property (nonatomic, copy) NSString                *name;
@property (nonatomic, copy) NSString                *date;
@property (nonatomic, copy) NSString                *imageURL;
@property (nonatomic, strong) UIImage               *image;

@property (nonatomic, weak) id<SAPImageDelegate> delegate;

+ (instancetype)imageWithImagePickerReferenceURL:(NSURL *)referenceURL
                                chapterReference:(FIRDatabaseReference *)chapterReference;

- (void)removeFromDatabase;
- (void)loadImage;

@end
