//
//  UITableView+PCSLoadingView.m
//  UITableView+PCSLoadingView-Example
//
//  Created by Peter Chen on 12/18/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "UITableView+PCSLoadingView.h"
#import <objc/runtime.h>

#define kUITableView_PCSLoadingView_StatusTextViewKey   @"kUITableView_PCSLoadingView_StatusTextViewKey"
#define kUITableView_PCSLoadingView_LoadingViewTextKey  @"kUITableView_PCSLoadingView_LoadingViewTextKey"
#define kUITableView_PCSLoadingView_NoDataViewTextKey   @"kUITableView_PCSLoadingView_NoDataViewTextKey"

#define kMargin 15

@implementation UITableView (PCSLoadingView)

//==================================================
#pragma mark - Status text view used for loading and no data views
//==================================================

- (UITextView *)_pcsStatusTextView {
    UITextView *textView = objc_getAssociatedObject(self, kUITableView_PCSLoadingView_StatusTextViewKey);
    if (! textView) {
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 2 * self.rowHeight + 1, self.frame.size.width, self.rowHeight - 2)];
        textView.userInteractionEnabled = NO;
        textView.editable = NO;
        textView.selectable = NO;
        textView.contentMode = UIViewContentModeCenter;
        
        textView.textAlignment = NSTextAlignmentCenter;
        textView.font = [UIFont boldSystemFontOfSize:17];
        textView.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        
        textView.hidden = YES;
        
        [self _pcsSetStatusTextView:textView];
        [self addSubview:textView];
    }
    return textView;
}

- (void)_pcsSetStatusTextView:(UITextView *)statusTextView {
    objc_setAssociatedObject(self, kUITableView_PCSLoadingView_StatusTextViewKey, statusTextView, OBJC_ASSOCIATION_RETAIN);
}

- (void)_pcsShowStatusTextViewWithText:(NSString *)text {
    UITextView *statusTextView = [self _pcsStatusTextView];
    statusTextView.hidden = NO;
    statusTextView.text = text;
    
    CGRect textRect = [text boundingRectWithSize:statusTextView.frame.size options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{ NSFontAttributeName : statusTextView.font }
                                         context:NULL];
    int textHeight = textRect.size.height;
    statusTextView.textContainerInset = UIEdgeInsetsMake((statusTextView.frame.size.height - textHeight) / 2, kMargin, 0, kMargin);
}

//==================================================
#pragma mark - Loading
//==================================================

- (NSString *)pcsLoadingViewText {
    NSString *text = objc_getAssociatedObject(self, kUITableView_PCSLoadingView_LoadingViewTextKey);
    if (! text) {
        text = @"Loading...";
        [self setPcsLoadingViewText:text];
    }
    return text;
}

- (void)setPcsLoadingViewText:(NSString *)pcsLoadingViewText {
    objc_setAssociatedObject(self, kUITableView_PCSLoadingView_LoadingViewTextKey, pcsLoadingViewText, OBJC_ASSOCIATION_RETAIN);
}

- (void)pcsShowLoadingView {
    [self _pcsShowStatusTextViewWithText:[self pcsLoadingViewText]];
}

- (void)pcsHideLoadingView {
    [self _pcsStatusTextView].hidden = YES;
}

//==================================================
#pragma mark - No Data
//==================================================

- (NSString *)pcsNoDataViewText {
    NSString *text = objc_getAssociatedObject(self, kUITableView_PCSLoadingView_NoDataViewTextKey);
    if (! text) {
        text = @"No Results";
        [self setPcsNoDataViewText:text];
    }
    return text;
}

- (void)setPcsNoDataViewText:(NSString *)pcsNoDataViewText {
    objc_setAssociatedObject(self, kUITableView_PCSLoadingView_NoDataViewTextKey, pcsNoDataViewText, OBJC_ASSOCIATION_RETAIN);
}

- (void)pcsShowNoDataView {
    [self _pcsShowStatusTextViewWithText:[self pcsNoDataViewText]];
}

- (void)pcsHideNoDataView {
    [self _pcsStatusTextView].hidden = YES;
}

@end
