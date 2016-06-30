//
//  DRBaseScorllSegC.h
//  Drex
//
//  Created by kunpeng on 16/3/2.
//  Copyright © 2016年 liukunpeng. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface KPScorllSegmentC : UIViewController

@property (nonatomic,assign) CGRect scrollViewFrame;
@property (nonatomic,assign) CGRect segmentViewFrame;
@property (nonatomic,strong) NSArray *scrollArray;
@property (nonatomic,strong) NSArray *segmentArray;
@property (nonatomic,strong) UIColor *segmentBackgroudColor;

/**
 *  获取滑动视图中当前页面的索引位置
 */
- (void)kpScrollView:(UIScrollView *)kpScrollView
horizenScrollToPageForIndex:(NSInteger)index;

/**
 *  选项按钮点击代理
 */
- (void)segmentClick:(NSInteger)clickIndex;

@end
