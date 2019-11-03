//
//  CalculatorButton.h
//  Calculator
//
//  Created by shesonglin on 2019/9/20.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorLogicProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorButton : UIButton

@property(assign) NSUInteger row;
@property(assign) NSUInteger column;

- (instancetype)initWithFrame:(CGRect)frame
                          Row:(NSUInteger)row
                       Column:(NSUInteger)column;
- (void)setImageWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
