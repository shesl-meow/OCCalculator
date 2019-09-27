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
@property(strong) NSString *nameText;
@property(strong) NSString *descriptionText;
@property(strong) UIImage *accessoryImage;
@property(strong, nonatomic) NSObject<CalculatorLogic> *calculatorLogic;
@property(strong, nonatomic) CalculatorScreenView *calculatorScreenView;
@property(strong, nonatomic) CalculatorButtonsNetView *calculatorButtonsNetView;
- (void)onClickCalculatorButton:(CalculatorButton *)sender;

@end

NS_ASSUME_NONNULL_END
