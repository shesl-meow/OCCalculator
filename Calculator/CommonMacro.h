//
//  CommonMacro.h
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h
#import <Foundation/Foundation.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, CalculatorOperator) {
    NoneOperator,
    PlusOperator,
    MinusOperator,
    MultipleOperator,
    DivideOperator,
    ModOperator
};


#define THEME_COLOR1 [UIColor colorWithRed:0x00/255.0 green:0x00/255.0 blue:0x00/255.0 alpha:1]
#define THEME_COLOR2 [UIColor colorWithRed:0x00/255.0 green:0x71/255.0 blue:0x75/255.0 alpha:1]
#define THEME_COLOR3 [UIColor colorWithRed:0xF1/255.0 green:0x88/255.0 blue:0x05/255.0 alpha:1]
#define THEME_COLOR4 [UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xFF/255.0 alpha:1]
#define THEME_COLOR5 [UIColor colorWithRed:0x5A/255.0 green:0x5A/255.0 blue:0x66/255.0 alpha:1]

#endif /* CommonMacro_h */
