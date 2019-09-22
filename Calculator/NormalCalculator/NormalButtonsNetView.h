//
//  NormalButtonsNetView.h
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../CalculatorModel/CalculatorButtonsNetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NormalButtonsNetView : CalculatorButtonsNetView

- initNetWithFrame:(CGRect)frame ClickDelegate:(NSObject<CalculatorClickDelegate> *)clickDelegate;

@end

NS_ASSUME_NONNULL_END
