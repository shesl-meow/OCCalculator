//
//  CalculatorButton.m
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "CalculatorButton.h"

@implementation CalculatorButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithRow:(NSUInteger)row andColumn:(NSUInteger)column {
    float sideLength = SCREEN_WIDTH * (0.9 / 4);
    float lrMargin = SCREEN_WIDTH * 0.05, topMargin = SCREEN_HEIGHT * 0.3;
    
    self = [super initWithFrame:CGRectMake(lrMargin + sideLength * column, topMargin + sideLength * row, sideLength, sideLength)];
    self.buttonPosition = BTN_CONVERT(row, column);
    self.backgroundColor = THEME_COLOR5;
    self.layer.borderWidth = 4.0f;
    self.layer.borderColor = THEME_COLOR4.CGColor;
    self.layer.cornerRadius = sideLength / 2;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return self;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    float sideLength = SCREEN_WIDTH * (0.9 / 4);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(sideLength * 0.2, sideLength * 0.2, sideLength * 0.2, sideLength * 0.2);
}

@end
