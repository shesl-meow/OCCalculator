//
//  CalculatorButton.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CommonMacro.h"
#import "CalculatorButton.h"

NS_ASSUME_NONNULL_BEGIN


@protocol CalculatorClickDelegate;


@interface CalculatorButtonsNetView : UIView

@property(nonatomic, assign) NSUInteger maxRow;

@property(nonatomic, assign) NSUInteger maxColumn;

@property(nonatomic, strong) NSMutableArray <NSMutableArray<CalculatorButton *> *> *calculatorButtons;

@property(nonatomic, weak) NSObject<CalculatorClickDelegate> *clickDelegate;

- (instancetype)initWithFrame:(CGRect)frame MaxRow:(NSUInteger)maxrow MaxColumn:(NSUInteger)maxcolumn ClickDelegate:(NSObject<CalculatorClickDelegate> *)clickDelegate;

@end


@protocol CalculatorClickDelegate <NSObject>

- (void)onClickCalculatorButton:(CalculatorButton *)sender;

@end

NS_ASSUME_NONNULL_END

