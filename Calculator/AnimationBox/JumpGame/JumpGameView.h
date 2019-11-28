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

@protocol JumpFailedDelegate <NSObject>

- (void)gameFailedHandler;

@end


@interface JumpGameView : UIView

@property(nonatomic, weak) NSObject<JumpFailedDelegate> *jumpFailedDelegate;

- (void)playJumpUp;

@end


NS_ASSUME_NONNULL_END
