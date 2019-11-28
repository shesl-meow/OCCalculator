//
//  ScienceController.m
//  Calculator
//
//  Created by shesonglin on 2019/9/24.
//  Copyright © 2019 shesonglin. All rights reserved.
//

#import "ScienceController.h"

@interface ScienceController ()

@end

@implementation ScienceController

@synthesize nameText = _nameText;
@synthesize descriptionText = _descriptionText;
@synthesize accessoryImage = _accessoryImage;
@synthesize calculatorButtonsNetView = _calculatorButtonsNetView;
@synthesize calculatorLogic = _calculatorLogic;
@synthesize calculatorScreenView = _calculatorScreenView;

- (instancetype)init
{
    self = [super init];
    if(self) {
        _nameText = @"SCIENCE";
        _descriptionText = @"假装是科学计算器的动画";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.nameText;
    self.view.backgroundColor = THEME_COLOR4;
    
    [self.view addSubview:self.pendulemView];
}

#pragma mark PropertyMethod

- (UIImage *)accessoryImage
{
    if(!_accessoryImage) {
        _accessoryImage = [UIImage imageNamed:@"science"];
    }
    return _accessoryImage;
}

- (PendulumView *)pendulemView
{
    if(!_pendulemView){
        CGFloat width = SCREEN_WIDTH, height = SCREEN_WIDTH / 2;
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT/2 - height/2 , width, height);
        _pendulemView = [[PendulumView alloc] initWithFrame:frame];
    }
    return _pendulemView;
}
@end
