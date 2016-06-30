//
//  KPSegmentView.h
//  主页面滑动
//
//  Created by kunpeng on 16/2/19.
//  Copyright © 2016年 zhiruiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KPSegmentViewDelegate <NSObject>

/**
 *  按钮点击回调
 *
 *  @param btnTag 按钮Tag
 */
- (void)segmentClick:(NSInteger)clickIndex;

@end

@interface KPSegmentView : UIView

/**
 *  代理
 */
@property (nonatomic,assign) id<KPSegmentViewDelegate>delegate;

/**
 *  按钮标题数组
 */
@property (nonatomic,strong) NSArray *segments;

/**
 * 设定选中按钮的位置(默认:0)
 */
@property (nonatomic,assign) NSInteger selectedSegmentIndex;

/**
 *  按钮字体样式及大小
 */
@property (nonatomic,strong) UIFont *segmentTitleFont;

/**
 *  按钮标题过渡前的颜色(默认:白色)
 */
@property (nonatomic,strong) UIColor *segmentStartColor;

/**
 *  按钮标题过渡后的颜色(默认:浅灰色)
 */
@property (nonatomic,strong) UIColor *segmentEndColor;

/**
 *  指示器颜色(默认:白色)
 */
@property (nonatomic,strong) UIColor *indicatorColor;

/**
 *  指示器高度(默认:3)
 */
@property (nonatomic,assign) CGFloat indicatorHeight;

/**
 *  底部滑动条动画方法
 */
- (void)sliderAnimation:(UIScrollView*)kpScrollView;

/**
 *  重载数据
 */
- (void)reload;
@end
