//
//  Calculator.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorLogic : NSObject

@property(strong) NSString *numberBuffer;
@property(assign) float left;
@property(assign) float right;
@property(assign) CalculatorOperator op;

- (NSString *)display;
- (float)doCalculate;
- (void)clear;
- (void)back;
- (void)append:(NSString *)number;
- (void)push:(CalculatorOperator)op;
- (void)equal;

@end

NS_ASSUME_NONNULL_END
