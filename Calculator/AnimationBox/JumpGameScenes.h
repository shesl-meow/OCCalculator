//
//  JumpGameScene.h
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JumpGameSceneModel : NSObject

@property(strong) UIColor *bottomgroundColor;
@property(strong) UIColor *backgroundColor;
@property(strong) UIColor *buildingColor;
@property(strong) UIColor *obstacleColor;
@property(strong) UIColor *sheslColor;

@end


@interface JumpGameScenes : NSObject{
    NSUInteger currentIndex;
}

@property(strong) NSMutableArray <JumpGameSceneModel *> *scenes;

- (JumpGameSceneModel *)randomPickScene;
- (JumpGameSceneModel *)currentScene;

@end

NS_ASSUME_NONNULL_END
