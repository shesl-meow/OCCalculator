//
//  ViewController.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"
#import "CalculatorLogic.h"
#import "CalculatorButton.h"
#import "CalculatorScreen.h"

@interface ViewController : UIViewController

@property(strong) CalculatorScreen *calculatorScreen;

- (void)clickCalculatorButton:(CalculatorButton *)sender;

@end

