//
//  UITableView+PCSLoadingView.h
//  UITableView+PCSLoadingView-Example
//
//  Created by Peter Chen on 12/18/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (PCSLoadingView)

// Loading
@property (nonatomic, strong) NSString *pcsLoadingViewText; // defaults to @"Loading..."

- (void)pcsShowLoadingView;
- (void)pcsHideLoadingView;

// No data
@property (nonatomic, strong) NSString *pcsNoDataViewText; // defaults to @"No Results"

- (void)pcsShowNoDataView;
- (void)pcsHideNoDataView;
- (void)pcsUpdateNoDataView; // shows or hides based on number of cells

@end
