//
//  KPScrollView.m
//  主页面滑动
//
//  Created by kunpeng on 16/2/19.
//  Copyright © 2016年 zhiruiyun. All rights reserved.
//

#import "KPScrollView.h"

#define WIDHT self.frame.size.width
#define HEIGHT self.frame.size.height

@interface KPScrollView ()

@property (nonatomic,strong) UIScrollView *baseScrollView;
@end

@implementation KPScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _baseScrollView = [[UIScrollView alloc]initWithFrame:
                           CGRectMake(0, 0, WIDHT,HEIGHT)];
        _baseScrollView.backgroundColor = [UIColor clearColor];
        _baseScrollView.tag = 1000;
        _baseScrollView.delegate = self;
        _baseScrollView.pagingEnabled = YES;
        [self addSubview:_baseScrollView];
    }
    return self;
}

- (void)setVisibleSubViewIndex:(NSInteger)visibleSubViewIndex {
    _visibleSubViewIndex = visibleSubViewIndex;
}

- (void)setContentHeight:(CGFloat)contentHeight {
    _contentHeight = contentHeight;
}

- (void)reload {
    
    NSInteger subViewCount = [_dataSource numberOfSubViewOnKPScrollView];
    _baseScrollView.contentSize = CGSizeMake(WIDHT * subViewCount,HEIGHT);
    _baseScrollView.contentOffset = CGPointMake(WIDHT * _visibleSubViewIndex, 0);
    [self addSubViewToKPScrollView:subViewCount];
}

//添加子视图到滑动视图
- (void)addSubViewToKPScrollView:(NSInteger)subViewCount {
    
    for (int index = 0; index < subViewCount; ++index) {
        UIScrollView *subScrollView = [_dataSource subScrollView:self
                                  pageVerticalScrollViewForIndex:index];
        subScrollView.frame = CGRectMake(WIDHT * index, 0, WIDHT, HEIGHT);
        subScrollView.tag = index;
        [_baseScrollView addSubview:subScrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([_delegate respondsToSelector:@selector(kpScrollViewDidScroll:)]) {
        [_delegate kpScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if ([_delegate respondsToSelector:@selector(kpScrollViewDidEndDecelerating:)]) {
        [_delegate kpScrollViewDidEndDecelerating:scrollView];
    }
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame));
    if ([_delegate respondsToSelector:@selector(kpScrollView:horizenScrollToPageForIndex:)]) {
        [_delegate kpScrollView:scrollView horizenScrollToPageForIndex:index];
    }
}

@end
