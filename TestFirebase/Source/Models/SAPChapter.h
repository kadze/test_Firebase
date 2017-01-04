//
//  SAPChapter.h
//  TestFirebase
//
//  Created by ASH on 1/4/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAPChapter : NSObject
@property (nonatomic, readonly) NSInteger imagesCount;

@property (nonatomic, readonly) NSDate *last;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;

@end
