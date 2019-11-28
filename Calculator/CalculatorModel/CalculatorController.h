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
#import "CalculatorLogicProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@protocol CalculatorController <NSObject>

@required
@property(nonatomic, strong) NSString *nameText;
@property(nonatomic, strong) NSString *descriptionText;
@property(nonatomic, strong) UIImage *accessoryImage;
@property(nonatomic, strong) NSObject<CalculatorLogicProtocol> *calculatorLogic;
@property(nonatomic, strong) CalculatorScreenView *calculatorScreenView;
@property(nonatomic, strong) CalculatorButtonsNetView *calculatorButtonsNetView;

- (void)onClickCalculatorButton:(CalculatorButton *)sender;

@end

NS_ASSUME_NONNULL_END
