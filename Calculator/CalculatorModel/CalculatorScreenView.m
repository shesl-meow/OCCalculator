//
//  CalculatorScreen.m
//  Calculator
//
//  Created by shesonglin on 2019/9/17.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "CalculatorScreenView.h"

@implementation CalculatorScreenView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];    
    if (self) {
        CGFloat fontSize = self.bounds.size.width / 12, radiusSize = 10;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        
        self.font = [UIFont boldSystemFontOfSize:fontSize];
        self.textAlignment = NSTextAlignmentRight;
        self.textColor = THEME_COLOR1;
        
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 4.0f;
        self.layer.borderColor = [THEME_COLOR1 colorWithAlphaComponent:0.5].CGColor;
        self.layer.cornerRadius = radiusSize;
        
        self.textContainerInset = UIEdgeInsetsMake(self.bounds.size.height / 2 - fontSize/2, self.bounds.size.height/2 - fontSize/2 - radiusSize, fontSize, fontSize);
        
        self.editable = NO;
        self.scrollEnabled = NO;
    }
    return self;
}

@end
