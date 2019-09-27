//
//  ViewController.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CalculatorModel/CalculatorController.h"

@interface MainViewController : UIViewController

@property(strong, nonatomic) UITableView *mainTableView;
@property(strong, nonatomic) NSMutableArray<UIViewController<CalculatorController> *> *calculatorControllerList;

@end

