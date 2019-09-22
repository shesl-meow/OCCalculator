//
//  NormalCalculatorController.h
//  Calculator
//
//  Created by shesonglin on 2019/9/19.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CalculatorModel/CalculatorController.h"
#import "../CalculatorModel/CalculatorButtonsNetView.h"
#import "../AnimationBox/JumpGameView.h"
#import "NormalLogic.h"
#import "NormalButtonsNetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NormalController : UIViewController<CalculatorController, CalculatorClickDelegate>

@property(strong) NSString *nameText;
@property(strong) NSString *descriptionText;
@property(strong) UIImage *accessoryImage;

@property(strong) NormalLogic<CalculatorLogic> *calculatorLogic;
@property(strong) CalculatorScreenView *calculatorScreenView;
@property(strong) NormalButtonsNetView *calculatorButtonsNetView;

@property(strong) JumpGameView *jumpGameView;

- (void)onClickCalculatorButton:(CalculatorButton *)sender;

@end

NS_ASSUME_NONNULL_END
