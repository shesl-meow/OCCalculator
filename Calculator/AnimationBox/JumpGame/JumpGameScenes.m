//
//  JumpGameScene.m
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "JumpGameScenes.h"
#import "../../CommonMacro.h"

@implementation JumpGameSceneModel

- (instancetype) init {
    self = [super init];
    if (self) {
        _bottomgroundColor = [[UIColor alloc] init];
        _backgroundColor = [[UIColor alloc] init];
        _buildingColor = [[UIColor alloc] init];
        _obstacleColor = [[UIColor alloc] init];
        _sheslColor = [[UIColor alloc] init];
        _buildingsList = [[NSMutableArray alloc] init];
        _obstacleImage = [[UIImage alloc] init];
    }
    return self;
}

@end

@implementation JumpGameScenes

- (instancetype)init {
    self = [super init];
    if (self) {
        _scenes = [[NSMutableArray alloc] initWithCapacity:1];
        
        JumpGameSceneModel *scene1 = [[JumpGameSceneModel alloc] init];
        scene1.bottomgroundColor = NUM2COLOR(0x00B74F, 1);
        scene1.backgroundColor = NUM2COLOR(0x00A9E0, 1);
        scene1.buildingColor = NUM2COLOR(0x004F71, 1);
        scene1.obstacleColor = NUM2COLOR(0x757575, 1);
        scene1.sheslColor = NUM2COLOR(0xFBFBFF, 1);
        
        for(int i = 0; i < 10; ++i){
            [scene1.buildingsList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"tree%d", i]]];
        }
        
        scene1.obstacleImage = [UIImage imageNamed:@"dart"];
        _scenes[0] =  scene1;
        
        [self randomPickScene];
    }
    return self;
}

- (JumpGameSceneModel *)currentScene {
    return _scenes[currentIndex];
}

#pragma mark Random

- (JumpGameSceneModel *)randomPickScene {
    currentIndex = arc4random_uniform((int)self.scenes.count);
    return _scenes[currentIndex];
}

- (UIImage *)randomPickBuilding {
    NSMutableArray <UIImage *> *buildings = self.currentScene.buildingsList;
//    ar
    NSInteger randomIndex = arc4random_uniform((int)buildings.count);
    return buildings[randomIndex];
}

@end
