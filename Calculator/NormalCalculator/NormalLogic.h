//
//  Calculator.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../CommonMacro.h"
#import "../CalculatorModel/CalculatorLogic.h"
#import "../CalculatorModel/CalculatorButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface NormalLogic : NSObject<CalculatorLogic>
- (NSString *)display;
- (void)onClickCalculatorButton:(CalculatorButton *)sender;

@property(strong) NSString *numberBuffer;
@property(assign) float left;
@property(assign) float right;
@property(assign) CalculatorOperator op;
- (void)clear;
- (void)back;
- (void)append:(NSString *)number;
- (void)push:(CalculatorOperator)op;
- (void)equal;
- (float)doCalculate;
@end

NS_ASSUME_NONNULL_END

/*
 Create button:
 AC      Back    %       /
 7       8       9       *
 4       5       6       -
 1       2       3       +
 NULL    0       .       =
 */
#define ROW_AMOUNT 5
#define COLUMN_AMOUNT 4
#define BTN_CONVERT(r,c) (r << 2) | c
typedef NS_OPTIONS(NSUInteger, CalculatorButtonName) {
    ClearButton     = BTN_CONVERT(0, 0),
    BackButton      = BTN_CONVERT(0, 1),
    
    ModButton       = BTN_CONVERT(0, 2),
    DivideButton    = BTN_CONVERT(0, 3),
    MutipleButton   = BTN_CONVERT(1, 3),
    MinusButton     = BTN_CONVERT(2, 3),
    PlusButton      = BTN_CONVERT(3, 3),
    EqualButton     = BTN_CONVERT(4, 3),
    
    ZeroButton      = BTN_CONVERT(4, 1),
    OneButton       = BTN_CONVERT(3, 0),
    TwoButton       = BTN_CONVERT(3, 1),
    ThreeButton     = BTN_CONVERT(3, 2),
    FourButton      = BTN_CONVERT(2, 0),
    FiveButton      = BTN_CONVERT(2, 1),
    SixButton       = BTN_CONVERT(2, 2),
    SevenButton     = BTN_CONVERT(1, 0),
    EightButton     = BTN_CONVERT(1, 1),
    NineButton      = BTN_CONVERT(1, 2),
    DotButton       = BTN_CONVERT(4, 2),
    
    NoneButton      = BTN_CONVERT(4, 0),
};
