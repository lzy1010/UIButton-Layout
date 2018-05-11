//
//  ViewController.m
//  UIButton+Layout
//
//  Created by zzc-13 on 2018/5/3.
//  Copyright © 2018年 lzy. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Layout.h"

@interface ViewController ()

@property (strong, nonatomic) UIButton *SDLBtn;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SDLBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor cyanColor]];
        
        [btn setImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"wx"] forState:UIControlStateNormal];
        [btn setTitle:@"哈哈" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:25];
        
        [btn setImageLayout:UIButtonLayoutImageRight space:10];
        
        btn;
    });
    
    [self.view addSubview:self.SDLBtn];
    
    self.SDLBtn.frame = CGRectMake(100, 100, 200, 200);
}


@end
