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

@property(nonatomic, strong) JumpGameScenes *jumpGameScenes;

@property(nonatomic, strong) UIImageView *runningShesl;
- (void)jumpUp;

@property(nonatomic, strong) UIView *bottomGround;

@property(nonatomic, strong) NSMutableArray<UIImageView *> *buildingsView;
- (void)buildingMoveForIndex:(NSUInteger)index;

@property(nonatomic, strong) NSMutableArray<UIImageView *> *obstaclesView;
- (void)obstacleMoveForIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
