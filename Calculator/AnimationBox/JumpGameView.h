//
//  JumpGameView.h
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JumpGameScenes.h"

NS_ASSUME_NONNULL_BEGIN

@interface JumpGameView : UIView

@property(strong, nonatomic) UIImageView *runningShesl;
@property(strong) UIView *bottomGround;

@property(strong, nonatomic) JumpGameScenes *jumpGameScenes;

@property(assign) NSInteger jumpDuration;
- (void)jumpUpAnimation;
- (void)jumpDownAnimation;

@end

NS_ASSUME_NONNULL_END
