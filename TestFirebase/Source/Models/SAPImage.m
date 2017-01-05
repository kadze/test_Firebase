//
//  SAPImage.m
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import "SAPImage.h"

#import <UIKit/UIImage.h>
#import <FirebaseDatabase/FirebaseDatabase.h>
#import <FirebaseStorage/FirebaseStorage.h>

#import "SAPConstants.h"

@implementation SAPImage

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithSnapshot:(FIRDataSnapshot *)snapshot {
    return [[self alloc] initWithSnapshot:snapshot];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSnapshot:(FIRDataSnapshot *)snapshot {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.uid = snapshot.key;
    self.reference = snapshot.ref;
    self.chapterReference = self.reference.parent;
    NSDictionary<NSString *, NSString *> *dictionary = snapshot.value;
    self.name = dictionary[@"name"];
    self.date = dictionary[@"date"];
    self.imageURL = dictionary[@"imageURL"];
    
    
    return self;
}

#pragma mark -
#pragma mark Public

- (NSDictionary *)dictionary {
    return @{@"name" : self.name,
             @"date" : self.date,
             @"imageURL" : self.imageURL};
}

- (void)addToDatabase {
    [[[self.chapterReference child:kSAPImages] childByAutoId] setValue:[self dictionary]];
}

- (void)loadImage {
    NSString *imageURL = _imageURL;
    if (imageURL) {
        if ([imageURL hasPrefix:@"gs://"]) {
            [[[FIRStorage storage] referenceForURL:imageURL] dataWithMaxSize:INT64_MAX
                                                                  completion:^(NSData *data, NSError *error)
             {
                 if (error) {
                     NSLog(@"Error downloading: %@", error);
                     return;
                 }
                 
                 UIImage *image = [UIImage imageWithData:data];
                 self.image = image;
                 [self.delegate delegatingSAPImage:self imageDidLoad:image];
             }];
        } else {
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
            self.image = image;
            [self.delegate delegatingSAPImage:self imageDidLoad:image];
        }
    }
}

@end
