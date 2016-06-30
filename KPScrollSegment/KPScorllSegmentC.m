//
//  DRBaseScorllSegC.m
//  Drex
//
//  Created by kunpeng on 16/3/2.
//  Copyright © 2016年 liukunpeng. All rights reserved.
//

#import "KPScorllSegmentC.h"
#import "KPScrollView.h"
#import "KPSegmentView.h"

#define WIDHT self.view.frame.size.width
#define HEIGHT self.view.frame.size.height
@interface KPScorllSegmentC ()<KPScrollViewDelegate,
                               KPScrollViewDataSource,
                               KPSegmentViewDelegate>

@property (nonatomic,strong) KPScrollView  *kpScrollView;
@property (nonatomic,strong) KPSegmentView *kpSegmentView;
@end

@implementation KPScorllSegmentC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupKPScrollView];
    [self setupKPSegmentView];
}

- (void)setup {
    
    _scrollArray = [NSMutableArray array];
}

- (void)setupKPScrollView {
    
    _kpScrollView = [[KPScrollView alloc]initWithFrame:
                      CGRectMake(0, 50, WIDHT, HEIGHT)];
    _kpScrollView.delegate = self;
    _kpScrollView.dataSource = self;
    [self.view addSubview:_kpScrollView];
}

- (void)setupKPSegmentView {
    
    _kpSegmentView = [[KPSegmentView alloc]initWithFrame:
                       CGRectMake(0, 0, WIDHT, 50)];
    _kpSegmentView.delegate = self;
    _kpSegmentView.segmentTitleFont = [UIFont systemFontOfSize:18];
    [self.view addSubview:_kpSegmentView];
}

- (void)setSegmentBackgroudColor:(UIColor *)segmentBackgroudColor {
    _kpSegmentView.backgroundColor = segmentBackgroudColor;
}

- (void)setScrollViewFrame:(CGRect)scrollViewFrame {
    _kpScrollView.frame = scrollViewFrame;
}

- (void)setSegmentViewFrame:(CGRect)segmentViewFrame {
    _kpSegmentView.frame = segmentViewFrame;
}

- (void)setSegmentArray:(NSArray *)segmentArray {
    _kpSegmentView.segments = segmentArray;
    [_kpSegmentView reload];
}

- (void)setScrollArray:(NSArray *)scrollArray {
    _scrollArray = scrollArray;
    [_kpScrollView reload];
}

- (void)setContentHeight:(CGFloat)contentHeight {
    _kpScrollView.contentHeight = contentHeight ?: HEIGHT;
}

- (NSInteger)numberOfSubViewOnKPScrollView {
    return _scrollArray.count;
}

- (UIScrollView*)subScrollView:(KPScrollView *)subScrollView
pageVerticalScrollViewForIndex:(NSInteger)index {
    
    UIScrollView *scrollView = _scrollArray[index];
    return scrollView;
}

- (void)kpScrollViewDidScroll:(UIScrollView*)kpScrollView {
    
    [_kpSegmentView sliderAnimation:kpScrollView];
}

- (void)segmentClick:(NSInteger)clickIndex {
    
    UIScrollView *scrollView = [_kpScrollView viewWithTag:1000];
    NSInteger offset = clickIndex - 1000;
    [scrollView setContentOffset:CGPointMake(offset * CGRectGetWidth(scrollView.frame), 0) animated:YES];
    [self kpScrollView:scrollView horizenScrollToPageForIndex:offset];
}

- (void)kpScrollView:(UIScrollView *)kpScrollView
horizenScrollToPageForIndex:(NSInteger)index {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
