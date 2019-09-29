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
#import "../AnimationBox/JumpGame/JumpGameView.h"
#import "NormalLogic.h"
#import "NormalButtonsNetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NormalController : UIViewController<CalculatorController, CalculatorClickDelegate, JumpFailedDelegate>

@property(strong, nonatomic) NormalLogic<CalculatorLogic> *calculatorLogic;
@property(strong, nonatomic) NormalButtonsNetView *calculatorButtonsNetView;

@property(strong, nonatomic) JumpGameView *jumpGameView;

- (void)gameFailedHandler;

@end

NS_ASSUME_NONNULL_END
