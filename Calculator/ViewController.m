//
//  ViewController.m
//  Calculator
//
//  Created by shesonglin on 2019/9/16.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "ViewController.h"
//#import "CalculatorLogic.h"

@interface ViewController ()

@property(strong) CalculatorLogic *calculatorLogic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.calculatorScreen = [[CalculatorScreen alloc] initScreen];
    [self.view addSubview:self.calculatorScreen];
    
    /*
     Create button:
     AC      Back    %       /
     7       8       9       *
     4       5       6       -
     1       2       3       +
     NULL    0       .       =
     */
    NSMutableArray *twoDimensionArr = [[NSMutableArray alloc] initWithCapacity:5];
    for(NSUInteger index = 0; index < 5; index++) {
        [twoDimensionArr insertObject:[[NSMutableArray alloc] initWithCapacity:4] atIndex:index];
    }
    for(int row = 0; row < 5; row++) {
        for(int column = 0; column < 4; column++) {
            CalculatorButton *thisButton = [[CalculatorButton alloc] initWithRow:row andColumn:column];
            [thisButton addTarget:self action:@selector(clickCalculatorButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:thisButton];
            twoDimensionArr[row][column] = thisButton;
        }
    }
    
    [twoDimensionArr[4][3] setImage:[UIImage imageNamed:@"equals"] forState:UIControlStateNormal];
    [twoDimensionArr[4][3] setBackgroundColor:THEME_COLOR3];
    [twoDimensionArr[3][3] setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [twoDimensionArr[3][3] setBackgroundColor:THEME_COLOR2];
    [twoDimensionArr[2][3] setImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [twoDimensionArr[2][3] setBackgroundColor:THEME_COLOR2];
    [twoDimensionArr[1][3] setImage:[UIImage imageNamed:@"times"] forState:UIControlStateNormal];
    [twoDimensionArr[1][3] setBackgroundColor:THEME_COLOR2];
    [twoDimensionArr[0][3] setImage:[UIImage imageNamed:@"divide"] forState:UIControlStateNormal];
    [twoDimensionArr[0][3] setBackgroundColor:THEME_COLOR2];
    [twoDimensionArr[0][2] setImage:[UIImage imageNamed:@"percent"] forState:UIControlStateNormal];
    [twoDimensionArr[0][2] setBackgroundColor:THEME_COLOR2];
    
    [twoDimensionArr[0][0] setImage:[UIImage imageNamed:@"cleared"] forState:UIControlStateNormal];
    [twoDimensionArr[0][0] setBackgroundColor:THEME_COLOR1];
    [twoDimensionArr[0][1] setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [twoDimensionArr[0][1] setBackgroundColor:THEME_COLOR1];
    
    [twoDimensionArr[4][1] setImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
    [twoDimensionArr[3][0] setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [twoDimensionArr[3][1] setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [twoDimensionArr[3][2] setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [twoDimensionArr[2][0] setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [twoDimensionArr[2][1] setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [twoDimensionArr[2][2] setImage:[UIImage imageNamed:@"6"] forState:UIControlStateNormal];
    [twoDimensionArr[1][0] setImage:[UIImage imageNamed:@"7"] forState:UIControlStateNormal];
    [twoDimensionArr[1][1] setImage:[UIImage imageNamed:@"8"] forState:UIControlStateNormal];
    [twoDimensionArr[1][2] setImage:[UIImage imageNamed:@"9"] forState:UIControlStateNormal];
    [twoDimensionArr[4][2] setImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
    
}

- (void)clickCalculatorButton:(CalculatorButton *)sender {
    NSLog(@"Detect button click!(%lu, %lu)", sender.buttonPosition >> 2, sender.buttonPosition & 3);
    switch (sender.buttonPosition) {
        case ClearButton:
            [self.calculatorLogic clear];
            break;
        case BackButton:
            [self.calculatorLogic back];
            break;
        case ZeroButton:
            [self.calculatorLogic append:@"0"];
            break;
        case OneButton:
            [self.calculatorLogic append:@"1"];
            break;
        case TwoButton:
            [self.calculatorLogic append:@"2"];
            break;
        case ThreeButton:
            [self.calculatorLogic append:@"3"];
            break;
        case FourButton:
            [self.calculatorLogic append:@"4"];
            break;
        case FiveButton:
            [self.calculatorLogic append:@"5"];
            break;
        case SixButton:
            [self.calculatorLogic append:@"6"];
            break;
        case SevenButton:
            [self.calculatorLogic append:@"7"];
            break;
        case EightButton:
            [self.calculatorLogic append:@"8"];
            break;
        case NineButton:
            [self.calculatorLogic append:@"9"];
            break;
        case DotButton:
            [self.calculatorLogic append:@"."];
            break;
        case PlusButton:
            [self.calculatorLogic push:PlusOperator];
            break;
        case MinusButton:
            [self.calculatorLogic push:MinusOperator];
            break;
        case MutipleButton:
            [self.calculatorLogic push:MultipleOperator];
            break;
        case DivideButton:
            [self.calculatorLogic push:DivideOperator];
            break;
        case ModButton:
            [self.calculatorLogic push:ModOperator];
            break;
        case EqualButton:
            [self.calculatorLogic equal];
            break;
        default:
            break;
    }
    NSString *status = [self.calculatorLogic display];
    self.calculatorScreen.text = status;
    NSLog(@"%@", status);
}

- (CalculatorLogic *)calculatorLogic {
    if (!_calculatorLogic) {
        _calculatorLogic = [[CalculatorLogic alloc] init];
    }
    return _calculatorLogic;
}

@end
