//
//  MyTableController.m
//  UITableView+PCSLoadingView-Example
//
//  Created by Peter Chen on 12/18/13.
//  Copyright (c) 2013 Peter Chen. All rights reserved.
//

#import "MyTableController.h"
#import "UITableView+PCSLoadingView.h"

@interface MyTableController ()

@property (nonatomic, strong) NSMutableArray *dummyStrings;

@end

@implementation MyTableController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.dummyStrings = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellId"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _startLoadingDummyData];
}

//==================================================
#pragma mark - Load dummy data
//==================================================

- (void)_startLoadingDummyData {
    [self.tableView pcsShowLoadingView];
    [self performSelector:@selector(_dummyDataDidLoad) withObject:nil afterDelay:2];
}

- (void)_dummyDataDidLoad {
    [self.tableView pcsHideLoadingView];
    
    if (0) {
        [self.dummyStrings setArray:@[ @"String 1", @"String 2" ]];
    }
    else {
        [self.dummyStrings removeAllObjects];
        [self.tableView pcsShowNoDataView];
    }
    
    [self.tableView reloadData];
}

//==================================================
#pragma mark - Table view
//==================================================

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dummyStrings count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    cell.textLabel.text = self.dummyStrings[indexPath.row];
    return cell;
}



@end
