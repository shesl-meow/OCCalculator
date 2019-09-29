//
//  NormalCalculatorController.m
//  Calculator
//
//  Created by shesonglin on 2019/9/19.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "../CommonMacro.h"
#import "NormalController.h"

@interface NormalController ()

@end

@implementation NormalController

@synthesize nameText = _nameText;
@synthesize descriptionText = _descriptionText;
@synthesize accessoryImage = _accessoryImage;
@synthesize calculatorScreenView = _calculatorScreenView;
@synthesize calculatorButtonsNetView = _calculatorButtonsNetView;

- (instancetype)init {
    self = [super init];
    _calculatorLogic = [[NormalLogic alloc] init];
    _nameText = @"NORMAL";
    _descriptionText = @"实现了加减乘除的简单计算器";
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.nameText;
    self.view.backgroundColor = THEME_COLOR4;
    
    [self.view addSubview:self.calculatorScreenView];
    [self.view addSubview:self.calculatorButtonsNetView];
    [self.view addSubview:self.jumpGameView];
}

#pragma mark PropertyMethod

- (UIImage *)accessoryImage{
    if(!_accessoryImage) _accessoryImage = [UIImage imageNamed:@"normal"];
    return _accessoryImage;
}

- (CalculatorScreenView *)calculatorScreenView {
    if(!_calculatorScreenView) {
        CGRect frame = CGRectMake(SCREEN_WIDTH * 0.05, SCREEN_HEIGHT*0.15, SCREEN_WIDTH * 0.9, SCREEN_HEIGHT * 0.12 - SCREEN_WIDTH * 0.05);
        _calculatorScreenView = [[CalculatorScreenView alloc] initWithFrame:frame];
    }
    return _calculatorScreenView;
}

- (CalculatorButtonsNetView *)calculatorButtonsNetView {
    if (!_calculatorButtonsNetView) {
        CGRect frame = CGRectMake(SCREEN_WIDTH*0.05, SCREEN_HEIGHT*0.27, SCREEN_WIDTH*0.9, SCREEN_HEIGHT*0.53);
        _calculatorButtonsNetView = [[NormalButtonsNetView alloc] initNetWithFrame:frame ClickDelegate:self];
    }
    return _calculatorButtonsNetView;
}

- (JumpGameView *)jumpGameView {
    if(!_jumpGameView) {
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT*0.8, SCREEN_WIDTH, SCREEN_HEIGHT * 0.15);
        _jumpGameView = [[JumpGameView alloc] initWithFrame:frame];
        _jumpGameView.jumpFailedDelegate = self;
    }
    return _jumpGameView;
}

#pragma mark CaculatorClickDelegate

- (void)onClickCalculatorButton:(CalculatorButton *)sender
{
    NSLog(@"Detect button click!(%lu, %lu)", sender.row, sender.column);
    CalculatorButtonName calculatorbuttonName = BTN_CONVERT(sender.row, sender.column);
    switch (calculatorbuttonName) {
        case ClearButton    :[self.calculatorLogic clear]; break;
        case BackButton     :[self.calculatorLogic back]; break;
        case ZeroButton     :[self.calculatorLogic append:@"0"]; break;
        case OneButton      :[self.calculatorLogic append:@"1"]; break;
        case TwoButton      :[self.calculatorLogic append:@"2"]; break;
        case ThreeButton    :[self.calculatorLogic append:@"3"]; break;
        case FourButton     :[self.calculatorLogic append:@"4"]; break;
        case FiveButton     :[self.calculatorLogic append:@"5"]; break;
        case SixButton      :[self.calculatorLogic append:@"6"]; break;
        case SevenButton    :[self.calculatorLogic append:@"7"]; break;
        case EightButton    :[self.calculatorLogic append:@"8"]; break;
        case NineButton     :[self.calculatorLogic append:@"9"]; break;
        case DotButton      :[self.calculatorLogic append:@"."]; break;
        case PlusButton     :[self.calculatorLogic push:PlusOperator]; break;
        case MinusButton    :[self.calculatorLogic push:MinusOperator]; break;
        case MutipleButton  :[self.calculatorLogic push:MultipleOperator]; break;
        case DivideButton   :[self.calculatorLogic push:DivideOperator]; break;
        case ModButton      :[self.calculatorLogic push:ModOperator]; break;
        case EqualButton    :[self.calculatorLogic equal]; break;
        case NoneButton     :[self.jumpGameView playJumpUp]; break;
        default: break;
    }
    NSString *status = [self.calculatorLogic display];
    self.calculatorScreenView.text = status;
    NSLog(@"%@", status);
}

#pragma mark JumpFailedDelegate

- (void)gameFailedHandler
{
    [self.calculatorLogic clear];
    self.calculatorScreenView.text = self.calculatorLogic.display;
}

@end
