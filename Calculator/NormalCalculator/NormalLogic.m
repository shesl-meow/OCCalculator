//
//  Calculator.m
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "NormalLogic.h"

@implementation NormalLogic

- (instancetype)init {
    self = [super init];
    self.numberBuffer = @"";
    self.left = 0;
    self.right = 0;
    self.op = NoneOperator;
    return self;
}

#pragma mark ExtensionMethod

- (float)doCalculate {
    if (self.op == PlusOperator) {
        self.left = self.left + self.right;
    } else if (self.op == MinusOperator) {
        self.left = self.left - self.right;
    } else if (self.op == MultipleOperator) {
        self.left = self.left * self.right;
    } else if (self.op == DivideOperator) {
        if (self.right == 0) {
            [self clear];
            return self.left;
        }
        self.left = self.left / self.right;
    } else if (self.op == ModOperator) {
        NSUInteger intLeft = self.left;
        NSUInteger intRight = self.right;
        if((_left - intLeft != 0) || (_right - intRight != 0) || (self.right == 0)) {
            [self clear];
            return self.left;
        }
        self.left = intLeft % intRight;
    }
    self.op = NoneOperator;
    self.right = 0;
    return self.left;
}

- (void)clear {
    self.left = 0;
    self.right = 0;
    self.op = NoneOperator;
    self.numberBuffer = @"";
}

- (void)back {
    NSUInteger length = [self.numberBuffer length];
    if (length != 0) {
        self.numberBuffer = [self.numberBuffer substringToIndex:(length - 1)];
    } else if (self.op != NoneOperator) {
        self.op = NoneOperator;
        self.numberBuffer = [[NSNumber numberWithFloat:self.left] stringValue];
        self.left = 0;
    }
}

- (void)append:(NSString *)number {
    self.numberBuffer = [self.numberBuffer stringByAppendingString:number];
}

- (void)push:(CalculatorOperator)op {
    if (self.op != NoneOperator) {
        self.right = [self.numberBuffer floatValue];
        self.numberBuffer = @"";
        [self doCalculate];
        self.op = op;
    } else {
        self.left = [self.numberBuffer floatValue];
        self.numberBuffer = @"";
        self.op = op;
    }
}

- (void)equal {
    self.right = [self.numberBuffer floatValue];
    [self doCalculate];
    self.numberBuffer = [[NSNumber numberWithFloat:self.left] stringValue];
    self.left = 0;
}

#pragma mark CalculatorLogic

- (NSString *)display {
    if (self.op == NoneOperator) {
        assert((self.left == 0) && (self.right == 0));
        return self.numberBuffer;
    } else {
        NSString *leftStr = [[NSNumber numberWithFloat:self.left] stringValue];
        if (self.op == PlusOperator) {
            return [NSString stringWithFormat:@"%@+%@", leftStr, self.numberBuffer];
        } else if (self.op == MinusOperator) {
            return [NSString stringWithFormat:@"%@-%@", leftStr, self.numberBuffer];
        } else if (self.op == MultipleOperator) {
            return [NSString stringWithFormat:@"%@*%@", leftStr, self.numberBuffer];
        } else if (self.op == DivideOperator) {
            return [NSString stringWithFormat:@"%@/%@", leftStr, self.numberBuffer];
        } else if (self.op == ModOperator) {
            return [NSString stringWithFormat:@"%@ mod %@", leftStr, self.numberBuffer];
        }
    }
    return @"";
}
@end
