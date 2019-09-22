//
//  CalculatorButton.m
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "CalculatorButtonsNetView.h"

@implementation CalculatorButtonsNetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame MaxRow:(NSUInteger)maxrow MaxColumn:(NSUInteger)maxcolumn ClickDelegate:(NSObject<CalculatorClickDelegate> *)clickDelegate{
    self = [super initWithFrame:frame];
    _maxRow = maxrow;
    _maxColumn = maxcolumn;
    _clickDelegate = clickDelegate;
    _calculatorButtons = [[NSMutableArray alloc] initWithCapacity:maxrow];
    for (int i = 0; i < maxrow; i++)
        _calculatorButtons[i] = [[NSMutableArray alloc] initWithCapacity:maxcolumn];
    
    CGFloat sideLength = self.bounds.size.width / maxcolumn;
    assert(self.bounds.size.height >= sideLength * maxrow);
    
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    for (int r = 0; r < maxrow; ++r) {
        CGFloat bntY = self.bounds.origin.y + r * sideLength;
        for(int c = 0; c < maxcolumn; ++c) {
            CGFloat bntX = self.bounds.origin.x + c * sideLength;
            CGRect bntFrame = CGRectMake(bntX, bntY, sideLength, sideLength);
            CalculatorButton *calculatorButton = [[CalculatorButton alloc] initWithFrame:bntFrame Row:r Column:c];
            
            [calculatorButton addTarget:self.clickDelegate action:@selector(onClickCalculatorButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:calculatorButton];
            self.calculatorButtons[r][c] = calculatorButton;
        }
    }
    return self;
}
@end
