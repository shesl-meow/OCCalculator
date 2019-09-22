//
//  CalculatorButton.m
//  Calculator
//
//  Created by shesonglin on 2019/9/20.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "../CommonMacro.h"
#import "CalculatorButton.h"

@implementation CalculatorButton

- (instancetype)initWithFrame:(CGRect)frame Row:(NSUInteger)row Column:(NSUInteger)column {
    self = [super initWithFrame:frame];
    if (self) {
        _row = row;
        _column = column;
        self.backgroundColor = THEME_COLOR5;
        self.layer.borderWidth = 4.0f;
        self.layer.borderColor = THEME_COLOR4.CGColor;
        self.layer.cornerRadius = self.bounds.size.width / 2;
    }
    return self;
}

- (void)setImageWithName:(NSString *)imageName{
    [super setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    CGFloat side = self.bounds.size.width * 0.2;
    self.imageEdgeInsets = UIEdgeInsetsMake(side, side, side, side);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
