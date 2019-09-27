//
//  ScienceController.h
//  Calculator
//
//  Created by shesonglin on 2019/9/24.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CalculatorModel/CalculatorController.h"
#import "../AnimationBox/Pendulum/PendulumView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScienceController : UIViewController<CalculatorController>

@property(strong, nonatomic) PendulumView *pendulemView;

@end

NS_ASSUME_NONNULL_END
