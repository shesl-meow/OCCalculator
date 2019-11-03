//
//  NormalButtonsNetView.m
//  Calculator
//
//  Created by shesonglin on 2019/9/22.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "NormalButtonsNetView.h"
#import "NormalLogic.h"

@implementation NormalButtonsNetView

- (instancetype)initNetWithFrame:(CGRect)frame ClickDelegate:(NSObject<CalculatorClickDelegate> *)clickDelegate 
{
    self = [super initWithFrame:frame MaxRow:ROW_AMOUNT MaxColumn:COLUMN_AMOUNT ClickDelegate:clickDelegate];
    
    if (!self) return self;
    for (int r = 0; r < self.maxRow; r++) {
        for (int c = 0; c < self.maxColumn; c++) {
            CalculatorButtonName buttonName = BTN_CONVERT(r, c);
            CalculatorButton *cb = self.calculatorButtons[r][c];
            switch (buttonName) {
                case PlusButton:
                    [cb setImageWithName:@"add"];
                    goto OperationButton;
                case MinusButton:
                    [cb setImageWithName:@"minus"];
                    goto OperationButton;
                case DivideButton:
                    [cb setImageWithName:@"divide"];
                    goto OperationButton;
                case MutipleButton:
                    [cb setImageWithName:@"multiple"];
                    goto OperationButton;
                case ModButton:
                    [cb setImageWithName:@"percent"];
                OperationButton:
                    [cb setBackgroundColor:THEME_COLOR2];
                    break;
                    
                case EqualButton:
                    [cb setImageWithName:@"equal"];
                    [cb setBackgroundColor:THEME_COLOR3];
                    break;
                    
                case NoneButton:
                    [cb setImageWithName:@"jump"];
                    goto ControlButton;
                case ClearButton:
                    [cb setImageWithName:@"clear"];
                    goto ControlButton;
                case BackButton:
                    [cb setImageWithName:@"delete"];
                ControlButton:
                    [cb setBackgroundColor:THEME_COLOR1];
                    break;
                    
                case OneButton:
                    [cb setImageWithName:@"1"];
                    goto NumberButton;
                case TwoButton:
                    [cb setImageWithName:@"2"];
                    goto NumberButton;
                case ThreeButton:
                    [cb setImageWithName:@"3"];
                    goto NumberButton;
                case FourButton:
                    [cb setImageWithName:@"4"];
                    goto NumberButton;
                case FiveButton:
                    [cb setImageWithName:@"5"];
                    goto NumberButton;
                case SixButton:
                    [cb setImageWithName:@"6"];
                    goto NumberButton;
                case SevenButton:
                    [cb setImageWithName:@"7"];
                    goto NumberButton;
                case EightButton:
                    [cb setImageWithName:@"8"];
                    goto NumberButton;
                case NineButton:
                    [cb setImageWithName:@"9"];
                    goto NumberButton;
                case ZeroButton:
                    [cb setImageWithName:@"0"];
                    goto NumberButton;
                case DotButton:
                    [cb setImageWithName:@"dot"];
                    goto NumberButton;
                NumberButton:
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}



@end
