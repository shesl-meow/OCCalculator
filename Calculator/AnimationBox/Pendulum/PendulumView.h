//
//  PendulumView.h
//  Calculator
//
//  Created by shesonglin on 2019/9/24.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PendulumView : UIView

@property(nonatomic, strong) NSMutableArray<UIView *> *circleViews;

@property(strong, nonatomic) NSMutableArray<UIView *> *shadowViews;

@property(strong, nonatomic) NSMutableArray<CAGradientLayer *> *gradientLayers;

- (void)irradiateCircleForIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
