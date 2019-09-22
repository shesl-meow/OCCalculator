//
//  CalculatorScreen.m
//  Calculator
//
//  Created by shesonglin on 2019/9/17.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "CalculatorScreenView.h"

@implementation CalculatorScreenView

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
        CGFloat fontSize = self.bounds.size.width / 12, radiusSize = 10;
        self.backgroundColor = THEME_COLOR1;
        self.font = [UIFont boldSystemFontOfSize:fontSize];
        self.textAlignment = NSTextAlignmentRight;
        self.textColor = THEME_COLOR4;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radiusSize;
        self.textContainerInset = UIEdgeInsetsMake(self.bounds.size.height/2 - fontSize/2 - radiusSize,
                                                   self.bounds.size.height/2 - fontSize/2 - radiusSize,
                                                   fontSize, fontSize);
    }
    return self;
}

@end
