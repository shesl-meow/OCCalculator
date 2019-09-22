//
//  CalculatorController.h
//  Calculator
//
//  Created by shesonglin on 2019/9/20.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorScreenView.h"
#import "CalculatorButtonsNetView.h"
#import "CalculatorLogic.h"


NS_ASSUME_NONNULL_BEGIN

@protocol CalculatorController <NSObject>

@required
@property(strong) NSString *displayName;
@property(strong) NSObject<CalculatorLogic> *calculatorLogic;
@property(strong) CalculatorScreenView *calculatorScreenView;
@property(strong) CalculatorButtonsNetView *calculatorButtonsNetView;
- (void)clickCalculatorButton:(CalculatorButtonsNetView *)sender;

@end

NS_ASSUME_NONNULL_END
