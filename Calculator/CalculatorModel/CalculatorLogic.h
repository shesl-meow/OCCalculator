//
//  CalculatorLogic.h
//  Calculator
//
//  Created by shesonglin on 2019/9/20.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CalculatorButton;

@protocol CalculatorLogic <NSObject>
@required
- (NSString *)display;
@end

NS_ASSUME_NONNULL_END
