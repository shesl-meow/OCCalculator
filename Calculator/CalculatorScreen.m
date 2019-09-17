//
//  CalculatorScreen.m
//  Calculator
//
//  Created by shesonglin on 2019/9/17.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "CalculatorScreen.h"

@implementation CalculatorScreen

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initScreen {
    float thisWidth = SCREEN_WIDTH * 0.9, lrMargin = SCREEN_WIDTH * 0.05;
    float thisHeight = SCREEN_HEIGHT * 0.12, topMargin = SCREEN_HEIGHT * 0.12;
    float fontSize = 40, radiusSize = 10;
    
    self = [super initWithFrame:CGRectMake(lrMargin, topMargin, thisWidth, thisHeight)];
    if (self) {
        self.backgroundColor = THEME_COLOR1;
        self.font = [UIFont boldSystemFontOfSize:fontSize];
        self.textAlignment = NSTextAlignmentRight;
        self.textColor = THEME_COLOR4;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radiusSize;
        self.textContainerInset = UIEdgeInsetsMake(thisHeight / 2 - fontSize / 2 - radiusSize / 2, thisHeight / 2 - fontSize / 2 - radiusSize / 2, lrMargin, lrMargin);
    }
    return self;
}

@end
