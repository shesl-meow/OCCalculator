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

@property(strong) UITableView *mainTableView;
@property(strong) NSMutableArray<UIViewController<CalculatorController> *> *calculatorControllerList;

@end

