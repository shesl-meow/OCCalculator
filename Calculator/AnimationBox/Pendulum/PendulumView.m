//
//  PendulumView.m
//  Calculator
//
//  Created by shesonglin on 2019/9/24.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "PendulumView.h"
#import "../../CommonMacro.h"

@interface PendulumView()<CAAnimationDelegate>{
    NSUInteger radius;
    NSUInteger duration;
}

@property(nonatomic, strong) CAKeyframeAnimation* leftPendulumAnimation;

@property(nonatomic, strong) CAKeyframeAnimation* rightPendulumAnimation;

@property(nonatomic, strong) CABasicAnimation* rightDownPendulumAnimation;

@end

@implementation PendulumView

- (instancetype)initWithFrame:(CGRect)frame
{
    /*
         设小球的半径是 r,
         
         考虑左右单摆的支点 O0,O1，第一个和最后一个小球的球心 C0,C6
         这四个点构成的矩形，令为黄金矩形，因为长边长 12r 因此短边长 12r*0.618；
         考虑小球的阴影，设其距离小球的底部一个半径，本身一个半径长度；
         考虑单摆的高度，设其摆动 60 度，经过计算可以得到球心的水平偏移 sqrt(3)*6r*0.618
         
         所以该 View 所需要的长宽为：26.844r * 10.416r
     */
    duration = 2;
    radius = MIN(frame.size.height / 10.416, frame.size.width / 26.844);
    frame = CGRectMake(frame.origin.x, frame.origin.y, 26.844*radius, 10.416*radius);
    self = [super initWithFrame:frame];
    if (self) {
        for(UIView *circle in self.circleViews){
            [self addSubview:circle];
        }
        for(UIView *shadow in self.shadowViews){
            [self addSubview:shadow];
        }
        
        __weak __typeof(self)weakSelf = self;
        NSTimer *timer0 = [NSTimer timerWithTimeInterval:0.03 repeats:YES block:^(NSTimer *timer){[weakSelf irradiateCircleForIndex:0];}];
        NSTimer *timer6 = [NSTimer timerWithTimeInterval:0.03 repeats:YES block:^(NSTimer *timer){[weakSelf irradiateCircleForIndex:6];}];
        [[NSRunLoop currentRunLoop] addTimer:timer0 forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] addTimer:timer6 forMode:NSDefaultRunLoopMode];
        [self.circleViews[0].layer addAnimation:[self leftPendulumAnimation] forKey:nil];
//        self.circleViews[0].layer.modelLayer.transform = CGAffineTransformMakeRotation(1/3 * M_PI);
    }
    return self;
}

#pragma mark ViewsProperty

- (NSMutableArray<UIView *> *)circleViews 
{
    if(!_circleViews) {
        _circleViews = [[NSMutableArray alloc] init];
        CGFloat y = (0.618 * 12 - 1) * radius, side = 2 * radius;
        for(NSUInteger i = 0; i < 7; ++i) {
            CGFloat x = 0.618 * 6 * 1.73 * radius + side * i;
            UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(x, y, side, side)];
            circle.layer.anchorPoint = CGPointMake(0.5, -3.208);
            circle.layer.position = CGPointMake(x + radius, 0);

            circle.layer.cornerRadius = radius;
            circle.backgroundColor = THEME_COLOR2;
            [_circleViews addObject:circle];
        }
    }
    return _circleViews;
}

- (NSMutableArray<UIView *> *)shadowViews 
{
    if(!_shadowViews){
        _shadowViews = [[NSMutableArray alloc] init];
        CGFloat y = 9.416 * radius, side = 2 * radius;
        for(NSUInteger i = 0; i < 7; ++i) {
            CGFloat x = 0.618 * 6 * 1.73 * radius + side * i;
            
            UIBezierPath *semicirclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius) radius:radius startAngle:0 endAngle:M_PI clockwise:NO];
            CAShapeLayer *shapeMask = [CAShapeLayer layer];
            shapeMask.path = semicirclePath.CGPath;

            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            UIColor *startColor = [THEME_COLOR2 colorWithAlphaComponent:(float)1/4];
            UIColor *endColor = [THEME_COLOR2 colorWithAlphaComponent:0];
            gradientLayer.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
            gradientLayer.frame = semicirclePath.bounds;
            gradientLayer.mask = shapeMask;
            UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(x, y, side, radius)];
            [shadowView.layer addSublayer:gradientLayer];
            
            [_shadowViews addObject:shadowView];
            [self.gradientLayers addObject:gradientLayer];
        }
    }
    return _shadowViews;
}

- (NSMutableArray<CAGradientLayer *> *)gradientLayers
{
    if(!_gradientLayers) _gradientLayers = [[NSMutableArray alloc] init];
    return _gradientLayers;
}

- (void)irradiateCircleForIndex:(NSUInteger)index 
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect pFrame = self.circleViews[index].layer.presentationLayer.frame;
        UIView *shadowView = self.shadowViews[index];
        CGRect frame = shadowView.frame;
        frame.origin.x = pFrame.origin.x;
        [shadowView setFrame:frame];
        
        CAGradientLayer *gradientLayer = self.gradientLayers[index];
        UIColor *startColor = [THEME_COLOR2 colorWithAlphaComponent:self->radius/(self.frame.size.height - pFrame.origin.y - pFrame.size.height) * 0.5];
        UIColor *endColor = [THEME_COLOR2 colorWithAlphaComponent:0];
        [gradientLayer setColors:@[(id)startColor.CGColor, (id)endColor.CGColor]];
    });
}

#pragma mark AnimationProperty

/*
    钟摆的动力学方程：\theta''(t) + g/l * sin(\theta) = 0
    在角度比较小的时候（虽然这里不是）有这样的动力学方程:
        \theta(t) = \theta_0 cos(k * t)
        其中，\thera_0 是钟摆速度为零时的角度，我们希望它等于 1/3 * pi
        再带入点 (0, duration) 即可求得 k
    然后我们将 cos x 进行泰勒展开，因为我们使用贝塞尔曲线进行模拟，因此只取第一项
        cos kx = 1 - 1/2 (kx)^2
        这还是一个二次函数，我们可以直接参考 JumpGame 中的q贝塞尔曲线。
 */

- (CAKeyframeAnimation *)leftPendulumAnimation
{
    if(!_leftPendulumAnimation){
        _leftPendulumAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        _leftPendulumAnimation.duration = duration;
        _leftPendulumAnimation.values = @[@(0), @((float)1/3 * M_PI), @(0)];
        _leftPendulumAnimation.keyTimes = @[@(0), @(0.5), @(1)];
        _leftPendulumAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithControlPoints:(float)1/3 :(float)2/3 :(float)2/3 :1],
            [CAMediaTimingFunction functionWithControlPoints:(float)1/3 :0 :(float)2/3 :(float)1/3],
        ];
        _leftPendulumAnimation.delegate = self;
        [_leftPendulumAnimation setValue:@"leftPendulumAnimation" forKey:@"animationName"];
    }
    return _leftPendulumAnimation;
}

- (CAKeyframeAnimation *)rightPendulumAnimation
{
    if(!_rightPendulumAnimation){
        _rightPendulumAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        _rightPendulumAnimation.duration = duration;
        _rightPendulumAnimation.values = @[@(0), @(-(float)1/3 * M_PI), @(0)];
        _leftPendulumAnimation.keyTimes = @[@(0), @(0.5), @(1)];
        _rightPendulumAnimation.timingFunctions = @[
            [CAMediaTimingFunction functionWithControlPoints:(float)1/3 :(float)2/3 :(float)2/3 :1],
            [CAMediaTimingFunction functionWithControlPoints:(float)1/3 :0 :(float)2/3 :(float)1/3],
        ];
        _rightPendulumAnimation.delegate = self;
        [_rightPendulumAnimation setValue:@"rightPendulumAnimation" forKey:@"animationName"];
    }
    return _rightPendulumAnimation;
}

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag 
{
    NSString *animationName = [anim valueForKey:@"animationName"];

    if ([animationName isEqual:@"leftPendulumAnimation"]) {
        [self.circleViews[6].layer addAnimation:self.rightPendulumAnimation forKey:nil];
    } else if ([animationName isEqual:@"rightPendulumAnimation"]) {
        [self.circleViews[0].layer addAnimation:self.leftPendulumAnimation forKey:nil];
    }
}

@end
