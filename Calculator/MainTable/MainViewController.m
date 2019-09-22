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
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.15)];
    headerView.text = headerString;
    headerView.font = [UIFont boldSystemFontOfSize:SCREEN_WIDTH * 0.75 / headerString.length];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT * 0.1;
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.calculatorControllerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController<CalculatorController> *calculatorController = self.calculatorControllerList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:calculatorController.nameText];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:calculatorController.nameText];
        cell.textLabel.text = calculatorController.nameText;
        cell.textLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT * 0.03];
        
        cell.detailTextLabel.text = calculatorController.descriptionText;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:SCREEN_HEIGHT * 0.02];
        
        cell.imageView.image = calculatorController.accessoryImage;
        
    }
    cell.textLabel.text = calculatorController.nameText;
    return cell;
}


@end
