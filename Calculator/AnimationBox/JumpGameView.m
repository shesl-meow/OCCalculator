//
//  JumpGameView.m
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "JumpGameView.h"
#import "../CommonMacro.h"

@interface JumpGameView()<CAAnimationDelegate> {
    NSUInteger jumpDuration;
    BOOL jumpDone;
    
    NSUInteger buildingAmount;
    NSUInteger buildingDuration;
    
    NSUInteger obstacleAmount;
    NSUInteger obstacleDuration;
}
@property(strong, nonatomic) CABasicAnimation *jumpUpAnimation;
@property(strong, nonatomic) CABasicAnimation *jumpDownAnimation;
@property(strong, nonatomic) CABasicAnimation *buildingMoveAnimation;
@property(strong, nonatomic) CABasicAnimation *obstacleMoveAnimation;

@end


@implementation JumpGameView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        jumpDuration = 1;
        jumpDone = YES;
        buildingAmount = 2;
        buildingDuration = 5;
        obstacleAmount = 1;
        obstacleDuration = 2;
        
        JumpGameSceneModel *currentScene = self.jumpGameScenes.currentScene;
        __weak __typeof(self) weakSelf = self;
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = self.bounds;
        gradient.colors = @[(id)[UIColor whiteColor].CGColor, (id)currentScene.backgroundColor.CGColor];
        [self.layer insertSublayer:gradient atIndex:0];
        
        [self addSubview:self.bottomGround];
        
        for(NSUInteger i = 0; i < buildingAmount; ++i) {
            [self addSubview:self.buildingsView[i]];
            dispatch_time_t delay =  dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * buildingDuration / buildingAmount *  i);
            dispatch_after(delay, dispatch_get_main_queue(), ^{
                [weakSelf buildingMoveForIndex:i];
            });
        }
        
        for(NSUInteger i = 0; i < obstacleAmount; ++i) {
            [self addSubview:self.obstaclesView[i]];
            dispatch_time_t delay =  dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * obstacleDuration / obstacleAmount *  i);
            dispatch_after(delay, dispatch_get_main_queue(), ^{
                [weakSelf obstacleMoveForIndex:i];
            });
        }
        
        [self addSubview:self.runningShesl];
    }
    return self;
}

#pragma mark PublicProperty

- (UIImageView *)runningShesl {
    if(!_runningShesl) {
        _runningShesl = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shesl"]];
        CGFloat side = self.bounds.size.height * 0.3;
        CGFloat x = self.bounds.origin.x + self.bounds.size.width * 0.1;
        CGFloat y = self.bounds.origin.y + self.bounds.size.height*0.9 - side;
        [_runningShesl setFrame:CGRectMake(x, y, side, side)];
    }
    return _runningShesl;
}

- (UIView *)bottomGround {
    if(!_bottomGround) {
        _bottomGround = [[UIView alloc] initWithFrame: CGRectMake(self.bounds.origin.x, self.bounds.origin.y + self.bounds.size.height * 0.9, self.bounds.size.width, self.bounds.size.height * 0.1)];
        [_bottomGround setBackgroundColor:self.jumpGameScenes.currentScene.bottomgroundColor];
    }
    return _bottomGround;
}

- (JumpGameScenes *)jumpGameScenes {
    if(!_jumpGameScenes){
        _jumpGameScenes = [[JumpGameScenes alloc] init];
    }
    return _jumpGameScenes;
}

- (NSMutableArray<UIImageView *> *)buildingsView {
    if(!_buildingsView) {
        _buildingsView = [[NSMutableArray alloc] initWithCapacity:buildingAmount];
        CGFloat side = self.frame.size.height * 0.9;
        CGFloat y = self.frame.size.height * 0.1;
        
        for(int i = 0;  i  < buildingAmount; ++i) {
            UIImageView *buildingView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, y, side, side)];
            _buildingsView[i] = buildingView;
        }
    }
    return _buildingsView;
}

- (NSMutableArray<UIImageView *> *)obstaclesView  {
    if(!_obstaclesView) {
        _obstaclesView = [[NSMutableArray alloc] initWithCapacity:obstacleAmount];
        CGFloat side = self.frame.size.height * 0.2;
        
        for(int i =0; i < obstacleAmount; ++i) {
            UIImageView *obstacleView = [[UIImageView alloc] initWithImage:self.jumpGameScenes.currentScene.obstacleImage];
            [obstacleView setFrame:CGRectMake(SCREEN_WIDTH, 0, side, side)];
            _obstaclesView[i] = obstacleView;
        }
    }
    return _obstaclesView;
}

#pragma mark ExtensionProperty

- (CABasicAnimation *)jumpUpAnimation {
    if(!_jumpUpAnimation) {
        _jumpUpAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        _jumpUpAnimation.fromValue = @(self.runningShesl.center.y);
        _jumpUpAnimation.toValue = @(self.runningShesl.center.y - self.runningShesl.frame.origin.y);
        /**
            function: y = t^2, x = t
            x(t) = 3at + (3c - 6a)t^2 + (1 -  3a - 3c)t^3  =>  x'(t) = 1  =>   (a,c) = (1/3, 2/3)
            y(t) = 3bt + (3d - 6b)t^2 + (1 - 3b - 3d)t^2  =>  y'(t) = t  =>   (b,d) = (0, 1/3)
         
            (a,b,c,d) = (1/3, 0, 2/3, 1/3)
            reverse (0,0) and (1,1)  =>  (a,b,c,d) = (1/3,2/3,2/3,1)
         */
        _jumpUpAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1/3 :2/3 :2/3 :1];
        _jumpUpAnimation.duration = jumpDuration;
        _jumpUpAnimation.delegate = self;
        [_jumpUpAnimation setValue:@"jumpUpAnimation" forKey:@"animationName"];

    }
    return _jumpUpAnimation;
}

- (CABasicAnimation *)jumpDownAnimation {
    if(!_jumpDownAnimation) {
        _jumpDownAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        _jumpDownAnimation.toValue = @(self.runningShesl.center.y);
        _jumpDownAnimation.fromValue = @(self.runningShesl.center.y - self.runningShesl.frame.origin.y);
        /**
            function: y = t^2, x = t
            x(t) = 3at + (3c - 6a)t^2 + (1 -  3a - 3c)t^3  =>  x'(t) = 1  =>   (a,c) = (1/3, 2/3)
            y(t) = 3bt + (3d - 6b)t^2 + (1 - 3b - 3d)t^2  =>  y'(t) = t  =>   (b,d) = (0, 1/3)
         
            (a,b,c,d) = (1/3, 0, 2/3, 1/3)
         */
        _jumpDownAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1/3 :0 :2/3 :1/3];
        _jumpDownAnimation.duration = jumpDuration;
        _jumpDownAnimation.delegate = self;
        [_jumpDownAnimation setValue:@"jumpDownAnimation" forKey:@"animationName"];

    }
    return _jumpDownAnimation;
}

- (CABasicAnimation *)buildingMoveAnimation {
    if(!_buildingMoveAnimation) {
        _buildingMoveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        _buildingMoveAnimation.fromValue = @(SCREEN_WIDTH + self.frame.size.height);
        _buildingMoveAnimation.toValue = @(-self.frame.size.height);
        _buildingMoveAnimation.duration = buildingDuration;
        
        _buildingMoveAnimation.delegate = self;
        [_buildingMoveAnimation setValue:@"buildingMoveAnimation" forKey:@"animationName"];
    }
    return _buildingMoveAnimation;
}

- (CABasicAnimation *)obstacleMoveAnimation {
    if (!_obstacleMoveAnimation) {
        _obstacleMoveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
        _obstacleMoveAnimation.fromValue = @(SCREEN_WIDTH + self.frame.size.height);
        _obstacleMoveAnimation.toValue = @(-self.frame.size.height);
        _obstacleMoveAnimation.duration = obstacleDuration;
        
        _obstacleMoveAnimation.delegate = self;
        [_obstacleMoveAnimation setValue:@"obstacleMoveAnimation" forKey:@"animationName"];
    }
    return _obstacleMoveAnimation;
}

#pragma mark Animation

- (void)jumpUp {
    if(jumpDone == NO) return;
    jumpDone = NO;
    [self.runningShesl.layer addAnimation:self.jumpUpAnimation forKey:nil];
}

- (void)buildingMoveForIndex:(NSUInteger)index {
    UIImageView *buildingView = self.buildingsView[index];
    [buildingView setImage:self.jumpGameScenes.randomPickBuilding];
    
    CABasicAnimation *moveAnimation = self.buildingMoveAnimation;
    [moveAnimation setValue:[[NSNumber alloc] initWithUnsignedInteger:index] forKey:@"animationIndex"];
    [buildingView.layer addAnimation:moveAnimation forKey:nil];
}

- (void)obstacleMoveForIndex:(NSUInteger)index {
    UIImageView *obstacleView = self.obstaclesView[index];
    CGFloat y = self.frame.size.height * 0.7 * ((float)rand() / RAND_MAX);
    CGFloat side = obstacleView.frame.size.height;
    [obstacleView setFrame:CGRectMake(SCREEN_WIDTH, y, side, side)];
    
    CABasicAnimation *moveAnimation = self.obstacleMoveAnimation;
    [moveAnimation setValue:[[NSNumber alloc] initWithUnsignedInteger:index] forKey:@"animationIndex"];

    dispatch_time_t delay =  dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * obstacleDuration * ((float)rand() / RAND_MAX));
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [obstacleView.layer addAnimation:moveAnimation forKey:nil];
    });
}

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    id animationName = [anim valueForKey:@"animationName"];
    if ([animationName isEqualToString:@"jumpUpAnimation"])
    {
        [self.runningShesl.layer addAnimation:self.jumpDownAnimation forKey:nil];
    } else if ([animationName isEqualToString:@"jumpDownAnimation"])
    {
        jumpDone = YES;
    } else if ([animationName isEqualToString:@"buildingMoveAnimation"])
    {
        NSNumber *index = [anim valueForKey:@"animationIndex"];
        [self buildingMoveForIndex:[index unsignedIntegerValue]];
    } else if ([animationName isEqualToString:@"obstacleMoveAnimation"])
    {
        NSNumber *index = [anim valueForKey:@"animationIndex"];
        [self obstacleMoveForIndex:[index unsignedIntegerValue]];
    }
}
@end
