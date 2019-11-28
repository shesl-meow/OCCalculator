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

@property(nonatomic, strong) UIColor *bottomgroundColor;

@property(nonatomic, strong) UIColor *backgroundColor;

@property(nonatomic, strong) UIColor *buildingColor;

@property(nonatomic, strong) UIColor *obstacleColor;

@property(nonatomic, strong) UIColor *sheslColor;

@property(nonatomic, strong) NSMutableArray <UIImage *> *buildingsList;

@property(nonatomic, strong) UIImage *obstacleImage;

@end


@interface JumpGameScenes : NSObject{
    NSUInteger currentIndex;
}

@property(nonatomic, strong) NSMutableArray <JumpGameSceneModel *> *scenes;

- (JumpGameSceneModel *)currentScene;

- (JumpGameSceneModel *)randomPickScene;

- (UIImage *)randomPickBuilding;

@end

NS_ASSUME_NONNULL_END
