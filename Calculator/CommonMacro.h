//
//  CommonMacro.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define BTN_CONVERT(r,c) (r << 2) | c

typedef NS_ENUM(NSInteger, CalculatorOperator) {
    NoneOperator, PlusOperator, MinusOperator, MultipleOperator, DivideOperator, ModOperator
};

typedef NS_OPTIONS(NSUInteger, CalculatorButtonPosition) {
    ClearButton     = BTN_CONVERT(0, 0),
    BackButton      = BTN_CONVERT(0, 1),
    
    ModButton       = BTN_CONVERT(0, 2),
    DivideButton    = BTN_CONVERT(0, 3),
    MutipleButton   = BTN_CONVERT(1, 3),
    MinusButton     = BTN_CONVERT(2, 3),
    PlusButton      = BTN_CONVERT(3, 3),
    EqualButton     = BTN_CONVERT(4, 3),
    
    ZeroButton      = BTN_CONVERT(4, 1),
    OneButton       = BTN_CONVERT(3, 0),
    TwoButton       = BTN_CONVERT(3, 1),
    ThreeButton     = BTN_CONVERT(3, 2),
    FourButton      = BTN_CONVERT(2, 0),
    FiveButton      = BTN_CONVERT(2, 1),
    SixButton       = BTN_CONVERT(2, 2),
    SevenButton     = BTN_CONVERT(1, 0),
    EightButton     = BTN_CONVERT(1, 1),
    NineButton      = BTN_CONVERT(1, 2),
    DotButton       = BTN_CONVERT(4, 2),
    
    NoneButton      = BTN_CONVERT(4, 0),
};

#define THEME_COLOR1 [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]
#define THEME_COLOR2 [UIColor colorWithRed:0x00/255.0 green:0x71/255.0 blue:0x75/255.0 alpha:1]
#define THEME_COLOR3 [UIColor colorWithRed:0xF1/255.0 green:0x88/255.0 blue:0x05/255.0 alpha:1]
#define THEME_COLOR4 [UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xFF/255.0 alpha:1]
#define THEME_COLOR5 [UIColor colorWithRed:0x5A/255.0 green:0x5A/255.0 blue:0x66/255.0 alpha:1]

#endif /* CommonMacro_h */
