//
//  DemoViewController.m
//  Demo
//
//  Created by kunpeng on 16/6/30.
//  Copyright © 2016年 liukunpeng. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *redView = [[UIView alloc]init];
    UIView *blueView = [[UIView alloc]init];
    UIView *orangeView = [[UIView alloc]init];
    
    orangeView.backgroundColor = [UIColor orangeColor];
    redView.backgroundColor = [UIColor redColor];
    blueView.backgroundColor = [UIColor blueColor];
    
    //此处请按照这个顺序进行设置
    //self.scrollViewFrame = 自定义frame值
    self.scrollArray = @[redView,blueView,orangeView];
    
    //此处请按照这个顺序进行设置
    //self.segmentViewFrame = 自定义frame值
    self.segmentArray = @[@"选项1",@"选项2",@"选项3"];
    self.segmentBackgroudColor = [UIColor orangeColor];
}

- (void)kpScrollView:(UIScrollView *)kpScrollView
horizenScrollToPageForIndex:(NSInteger)index {
    //在这里实现滑动时对应的操作
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
