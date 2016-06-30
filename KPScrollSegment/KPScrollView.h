//
//  KPScrollView.h
//  主页面滑动
//
//  Created by kunpeng on 16/2/19.
//  Copyright © 2016年 zhiruiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPScrollView;

@protocol KPScrollViewDataSource <NSObject>
@required

/**
 *  子视图的数量
 */
- (NSInteger)numberOfSubViewOnKPScrollView;

/**
 *  子视图对象
 *
 *  @param subScrollView 子视图
 *  @param index         子视图索引
 */
- (UIScrollView*)subScrollView:(KPScrollView*)subScrollView pageVerticalScrollViewForIndex:(NSInteger)index;

@end

@protocol KPScrollViewDelegate <NSObject>

@optional
/**
 *  通知代理接收用户滑动中的事件
 */
- (void)kpScrollViewDidScroll:(UIScrollView*)kpScrollView;

/**
 *  通知代理接收用户滑动结束的事件
 */
- (void)kpScrollViewDidEndDecelerating:(UIScrollView *)kpScrollView;

/**
 *  通知代理接收用户刷新和加载事件
 */
- (void)kpScrollViewRefresh:(UIScrollView*)kpScrollView;

/**
 *  通知代理接收用户滑动页面事件
 */
- (void)kpScrollView:(UIScrollView*)kpScrollView horizenScrollToPageForIndex:(NSInteger)index;

@end

@interface KPScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic,assign) id<KPScrollViewDelegate>delegate;
@property (nonatomic,assign) id<KPScrollViewDataSource>dataSource;

/**
 *  手动设置第一显示的子视图
 */
@property (nonatomic,assign) NSInteger visibleSubViewIndex;

/**
 *  设置contentSize的height值
 */
@property (nonatomic,assign) CGFloat contentHeight;

/**
 *  重载
 */
- (void)reload;

@end
