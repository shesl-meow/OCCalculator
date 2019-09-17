//
//  CalculatorButton.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorButton : UIButton

@property(assign) CalculatorButtonPosition buttonPosition;

- (instancetype)initWithRow:(NSUInteger)row andColumn:(NSUInteger)column;

@end

NS_ASSUME_NONNULL_END
