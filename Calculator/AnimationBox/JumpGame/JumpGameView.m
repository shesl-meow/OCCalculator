//
//  JumpGameView.m
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "JumpGameView.h"
#import "../../CommonMacro.h"

@interface JumpGameView()<CAAnimationDelegate> {
    NSUInteger jumpDuration;
    BOOL jumpDone;
    
    NSUInteger buildingAmount;
    NSUInteger buildingDuration;
    
    NSUInteger obstacleAmount;
    NSUInteger obstacleDuration;
    
    BOOL dieState;
}

@property(nonatomic, strong) JumpGameScenes *jumpGameScenes;
@property(nonatomic, strong) UIImageView *runningShesl;
@property(nonatomic, strong) UIView *bottomGround;
@property(nonatomic, strong) NSMutableArray<UIImageView *> *buildingsView;
@property(nonatomic, strong) NSMutableArray<UIImageView *> *obstaclesView;

@property(strong, nonatomic) CABasicAnimation *jumpUpAnimation;
@property(strong, nonatomic) CABasicAnimation *jumpDownAnimation;
@property(strong, nonatomic) CABasicAnimation *buildingMoveAnimation;
@property(strong, nonatomic) CABasicAnimation *obstacleMoveAnimation;

- (void)playBuildingMoveForIndex:(NSUInteger)index;
- (void)playObstacleMoveForIndex:(NSUInteger)index;

- (void)checkDangerous;
- (void)stopAllAnimations;
- (void)continueAllAnimations;

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
        dieState = NO;
        
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
                [weakSelf playBuildingMoveForIndex:i];
            });
        }
        
        for(NSUInteger i = 0; i < obstacleAmount; ++i) {
            [self addSubview:self.obstaclesView[i]];
            dispatch_time_t delay =  dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * obstacleDuration / obstacleAmount *  i);
            dispatch_after(delay, dispatch_get_main_queue(), ^{
                [weakSelf playObstacleMoveForIndex:i];
            });
        }
        
        [self addSubview:self.runningShesl];
        [self.runningShesl setTintColor:currentScene.sheslColor];
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(checkDangerous) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

#pragma mark ViewsProperty

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

#pragma mark AnimationProperty

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
        _jumpUpAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:(float)1/3 :(float)2/3 :(float)2/3 :1];
        _jumpUpAnimation.duration = jumpDuration;
        _jumpUpAnimation.removedOnCompletion = NO;
        _jumpUpAnimation.fillMode = kCAFillModeForwards;
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
        _jumpDownAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:(float)1/3 :0 :(float)2/3 :(float)1/3];
        _jumpDownAnimation.duration = jumpDuration;
        _jumpDownAnimation.removedOnCompletion = NO;
        _jumpDownAnimation.fillMode = kCAFillModeForwards;
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

#pragma mark PlayAnimation

- (void)playJumpUp {
    if(jumpDone == NO) return;
    jumpDone = NO;
    [self.runningShesl.layer addAnimation:self.jumpUpAnimation forKey:nil];
}

- (void)playBuildingMoveForIndex:(NSUInteger)index {
    UIImageView *buildingView = self.buildingsView[index];
    [buildingView setImage:self.jumpGameScenes.randomPickBuilding];
    
    CABasicAnimation *moveAnimation = self.buildingMoveAnimation;
    [moveAnimation setValue:[[NSNumber alloc] initWithUnsignedInteger:index] forKey:@"animationIndex"];
    [buildingView.layer addAnimation:moveAnimation forKey:nil];
}

- (void)playObstacleMoveForIndex:(NSUInteger)index {
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

#pragma mark GameCore

- (void)checkDangerous {
    CGRect sheslLayerFrame = jumpDone ? self.runningShesl.frame :[self.runningShesl.layer presentationLayer].frame;
    for (UIImageView *obstacleView in self.obstaclesView) {
        CGRect obstacleLayerFrame = [obstacleView.layer presentationLayer].frame;
        if(CGRectIntersectsRect(sheslLayerFrame, obstacleLayerFrame)) {
            if(!dieState){
                dieState = YES;
                [self.jumpFailedDelegate gameFailedHandler];
                [self stopAllAnimations];
                dispatch_after(
                               dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2), dispatch_get_main_queue(),
                               ^{[self continueAllAnimations];}
                               );
            }
            return;
        }
    }
    dieState = NO;
}

- (void)stopAllAnimations {
    dispatch_queue_t queue = dispatch_get_main_queue();
//    dieState = YES;
    
    for(UIImageView *buildingView in self.buildingsView) {
        dispatch_async(queue, ^{
            CFTimeInterval pauseTime = [buildingView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
            buildingView.layer.timeOffset = pauseTime;
            buildingView.layer.speed = 0;
        });
    }
    for(UIImageView *obstacleView in self.obstaclesView) {
        dispatch_async(queue, ^{
            CFTimeInterval pauseTime = [obstacleView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
            obstacleView.layer.timeOffset = pauseTime;
            obstacleView.layer.speed = 0;
        });
    }
    dispatch_async(queue, ^{
        CFTimeInterval pauseTime = [self.runningShesl.layer  convertTime:CACurrentMediaTime() fromLayer:nil];
        self.runningShesl.layer.timeOffset = pauseTime;
        self.runningShesl.layer.speed = 0;
    });
}

- (void)continueAllAnimations {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    for (UIImageView *buildingView in self.buildingsView) {
        dispatch_async(queue, ^{
            CFTimeInterval pauseTime = buildingView.layer.timeOffset;
            buildingView.layer.timeOffset = 0;
            buildingView.layer.beginTime = CACurrentMediaTime() - pauseTime;
            buildingView.layer.speed = 1;
        });
    }
    
    for (UIImageView *obstacleView in self.obstaclesView) {
        dispatch_async(queue, ^{
            CFTimeInterval pauseTime = obstacleView.layer.timeOffset;
            obstacleView.layer.timeOffset = 0;
            obstacleView.layer.beginTime = CACurrentMediaTime() - pauseTime;
            obstacleView.layer.speed = 1;
        });
    }
    
    dispatch_async(queue, ^{
        CFTimeInterval pauseTime = self.runningShesl.layer.timeOffset;        
        self.runningShesl.layer.timeOffset = 0;
        self.runningShesl.layer.beginTime = CACurrentMediaTime() - pauseTime;
        self.runningShesl.layer.speed = 1;
    });
    dispatch_group_leave(group);
//    dispatch_group_notify(group, queue, ^{self->dieState = NO;});
}

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *animationName = [anim valueForKey:@"animationName"];
    if (flag) {
        if ([animationName isEqualToString:@"jumpUpAnimation"])
        {
            [self.runningShesl.layer addAnimation:self.jumpDownAnimation forKey:nil];
        } else if ([animationName isEqualToString:@"jumpDownAnimation"])
        {
            jumpDone = YES;
        } else if ([animationName isEqualToString:@"buildingMoveAnimation"])
        {
            NSNumber *index = [anim valueForKey:@"animationIndex"];
            [self playBuildingMoveForIndex:[index unsignedIntegerValue]];
        } else if ([animationName isEqualToString:@"obstacleMoveAnimation"])
        {
            NSNumber *index = [anim valueForKey:@"animationIndex"];
            [self playObstacleMoveForIndex:[index unsignedIntegerValue]];
        }
    } else {
        if ([animationName  isEqual: @"jumpUpAnimation"]) {
            jumpDone = YES;
        }  else if ([animationName isEqual: @"jumpDownAnimation"]) {
            jumpDone = YES;
        }
    }
}
@end
