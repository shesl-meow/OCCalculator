//
//  ViewController.m
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "MainViewController.h"
#import "../CalculatorModel/CalculatorController.h"
#import "../NormalCalculator/NormalController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    
    NSString *headerString = @"CALCULATOR";
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.1)];
    headerView.text = headerString;
    headerView.font = [UIFont boldSystemFontOfSize:SCREEN_WIDTH * 0.6 / headerString.length];
    headerView.textAlignment = NSTextAlignmentCenter;
    self.mainTableView.tableHeaderView = headerView;
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
}

- (NSMutableArray<UIViewController<CalculatorController> *> *)calculatorControllerList {
    if (!_calculatorControllerList) {
        _calculatorControllerList = [[NSMutableArray alloc] initWithObjects:[[NormalController alloc] init], nil];
    }
    return _calculatorControllerList;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Enter controller: %zi", indexPath.row);
    [self.navigationController pushViewController:_calculatorControllerList[indexPath.row] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.calculatorControllerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testcell"];
    }
    cell.textLabel.text = self.calculatorControllerList[indexPath.row].displayName;
    return cell;
}


@end
