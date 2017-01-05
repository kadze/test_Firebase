//
//  SAPViewModelDelegate.h
//  TestFirebase
//
//  Created by ASH on 1/5/17.
//  Copyright © 2017 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAPViewModelDelegate <NSObject>
- (void)viewModelDidChange:(id)viewModel;

@end
