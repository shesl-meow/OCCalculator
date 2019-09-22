//
//  JumpGameView.m
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "JumpGameView.h"

@interface JumpGameView()<CAAnimationDelegate>

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
        [self addSubview:self.runningShesl];
        [self addSubview:self.bottomGround];
        _jumpDuration = 1;
    }
    return self;
}

#pragma mark Property

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

#pragma mark Animation

- (void)jumpUpAnimation {
    CABasicAnimation *jump = [CABasicAnimation animationWithKeyPath:@"position.y"];
    jump.fromValue = @(self.runningShesl.center.y);
    jump.toValue = @(self.runningShesl.center.y - self.runningShesl.frame.origin.y);
    /**
        function: y = t^2, x = t
        x(t) = 3at + (3c - 6a)t^2 + (1 -  3a - 3c)t^3  =>  x'(t) = 1  =>   (a,c) = (1/3, 2/3)
        y(t) = 3bt + (3d - 6b)t^2 + (1 - 3b - 3d)t^2  =>  y'(t) = t  =>   (b,d) = (0, 1/3)
     
        (a,b,c,d) = (1/3, 0, 2/3, 1/3)
        reverse (0,0) and (1,1)  =>  (a,b,c,d) = (1/3,2/3,2/3,1)
     */
    jump.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1/3 :2/3 :2/3 :1];
    jump.duration = self.jumpDuration;
    jump.delegate = self;
    [jump setValue:@"jumpUpAnimation" forKey:@"animationName"];
    [self.runningShesl.layer addAnimation:jump forKey:nil];
}

- (void)jumpDownAnimation {
    CABasicAnimation *jump = [CABasicAnimation animationWithKeyPath:@"position.y"];
    jump.toValue = @(self.runningShesl.center.y);
    jump.fromValue = @(self.runningShesl.center.y - self.runningShesl.frame.origin.y);
    /**
        function: y = t^2, x = t
        x(t) = 3at + (3c - 6a)t^2 + (1 -  3a - 3c)t^3  =>  x'(t) = 1  =>   (a,c) = (1/3, 2/3)
        y(t) = 3bt + (3d - 6b)t^2 + (1 - 3b - 3d)t^2  =>  y'(t) = t  =>   (b,d) = (0, 1/3)
     
        (a,b,c,d) = (1/3, 0, 2/3, 1/3)
     */
    jump.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1/3 :0 :2/3 :1/3];
    jump.duration = self.jumpDuration;
    jump.delegate = self;
    [jump setValue:@"animationName" forKey:@"jumpDownAnimation"];
    [self.runningShesl.layer addAnimation:jump forKey:nil];
}

#pragma mark CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:@"animationName"] isEqualToString:@"jumpUpAnimation"]) {
        [self jumpDownAnimation];
    }}
@end
