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
#import <FirebaseCore/FirebaseCore.h>
#import <Photos/Photos.h>

#import "SAPConstants.h"

@interface SAPImage ()
@property (nonatomic, strong) NSURL                 *referenceURL;
//@property (nonatomic, strong) FIRStorageReference   *storageReference;

@end

@implementation SAPImage

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageWithSnapshot:(FIRDataSnapshot *)snapshot {
    return [[self alloc] initWithSnapshot:snapshot];
}

+ (instancetype)imageWithImagePickerReferenceURL:(NSURL *)referenceURL
                                chapterReference:(FIRDatabaseReference *)chapterReference
{
    return [[self alloc] initWithImagePickerReferenceURL:referenceURL chapterReference:chapterReference];
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

- (instancetype)initWithImagePickerReferenceURL:(NSURL *)referenceURL
                                chapterReference:(FIRDatabaseReference *)chapterReference
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (!referenceURL) {
        return nil;
    }
    
    self.referenceURL = referenceURL;
    self.chapterReference = chapterReference;
    
    return self;
}

#pragma mark -
#pragma mark Public

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[SAPImage class]]) {
        return NO;
    }
    
    FIRDatabaseReference *reference = [object reference];
    if ([_reference.key isEqualToString:reference.key] &&
        [_reference.parent.key isEqualToString:reference.parent.key]) {
        return YES;
    }
    
    return NO;
}

- (NSDictionary *)dictionary {
    return @{@"name" : self.name,
             @"date" : self.date,
             @"imageURL" : self.imageURL};
}

- (void)addToDatabase {
    if (self.referenceURL) {
        NSString *storageUrl = [FIRApp defaultApp].options.storageBucket;
        FIRStorageReference *storageReference = [[FIRStorage storage] referenceForURL:[NSString stringWithFormat:@"gs://%@", storageUrl]];
        
        PHFetchResult* assets = [PHAsset fetchAssetsWithALAssetURLs:@[self.referenceURL] options:nil];
        PHAsset *asset = [assets firstObject];
        [asset requestContentEditingInputWithOptions:nil
                                   completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
                                       NSURL *imageFile = contentEditingInput.fullSizeImageURL;
                                       NSString *filePath = [NSString stringWithFormat:@"%lld/%@",
                                                             (long long)([[NSDate date] timeIntervalSince1970] * 1000.0),
                                                             [self.referenceURL lastPathComponent]];
                                       [[storageReference child:filePath] putFile:imageFile
                                                                              metadata:nil
                                                                            completion:^(FIRStorageMetadata *metadata, NSError *error)
                                        {
                                            if (error) {
                                                NSLog(@"Error uploading: %@", error);
                                                
                                                return;
                                            }
                                            
                                            self.name = [self.referenceURL lastPathComponent];
                                            self.date = @"";
                                            self.imageURL = [storageReference child:metadata.path].description;
                                            
                                            [[[self.chapterReference child:kSAPImages] childByAutoId] setValue:[self dictionary]];
                                        }];
                                   }];
    }
}

- (void)removeFromDatabase {
    [[[FIRStorage storage] referenceForURL:self.imageURL] deleteWithCompletion:^(NSError * _Nullable error) {
        [self.reference removeValue];
    }];
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

//- (void)configureStorage {
//    NSString *storageUrl = [FIRApp defaultApp].options.storageBucket;
//    self.storageReference = [[FIRStorage storage] referenceForURL:[NSString stringWithFormat:@"gs://%@", storageUrl]];
//}

@end
