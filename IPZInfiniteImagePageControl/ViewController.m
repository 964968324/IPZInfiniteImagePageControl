//
//  ViewController.m
//  IPZInfiniteImagePageControl
//
//  Created by 刘宁 on 15/12/30.
//  Copyright © 2015年 ipaynow. All rights reserved.
//

#import "ViewController.h"
#import "IPZInfiniteImagePageControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect frame = CGRectMake(0, 60, self.view.bounds.size.width, 200);
    
    NSArray *imageArray = @[@"001.jpg", @"002.jpg", @"003.jpg", @"004.jpg", @"005.jpg"];
    
    //初始化控件
    IPZInfiniteImagePageControl *iipc = [[IPZInfiniteImagePageControl alloc]initWithFrame:frame andImageArrar:imageArray];
    [self.view addSubview:iipc];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
