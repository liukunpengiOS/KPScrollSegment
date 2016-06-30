//
//  KPSegmentView.m
//  主页面滑动
//
//  Created by kunpeng on 16/2/19.
//  Copyright © 2016年 zhiruiyun. All rights reserved.
//

#import "KPSegmentView.h"
#import "INTUAnimationEngine.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
@interface KPSegmentView ()

@property (nonatomic,strong) UIButton       *segmentBtn;
@property (nonatomic,strong) UIButton       *selectedBtn;
@property (nonatomic,strong) UIView         *indicatorView;
@property (nonatomic,strong) UIColor        *btnStartColor;
@property (nonatomic,strong) UIColor        *btnEndColor;
@property (nonatomic,strong) UIFont         *btnTitleFont;
@property (nonatomic,assign) CGFloat        indicatorViewHeight;
@property (nonatomic,strong) NSMutableArray *segmentBtnArray;
@end

@implementation KPSegmentView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
    
         _segmentBtnArray = [NSMutableArray array];
    }
    return self;
}

- (void)setSegmentTitleFont:(UIFont *)segmentTitleFont {
    
    _segmentTitleFont = segmentTitleFont;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    
    _indicatorColor = indicatorColor;
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight {
    
    _indicatorHeight = indicatorHeight;
}

- (void)setSegmentStartColor:(UIColor *)segmentStartColor {
    
    _segmentStartColor = segmentStartColor;
}
- (void)setSegmentEndColor:(UIColor *)segmentEndColor {
    
    _segmentEndColor = segmentEndColor;
}

- (void)setSegments:(NSArray *)segments {
    
    _segments = segments;
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    
    _selectedSegmentIndex = selectedSegmentIndex;
}

- (void)reload {
    
    _indicatorViewHeight = _indicatorHeight ? _indicatorHeight : 3;
    _btnStartColor = _segmentStartColor ? _segmentStartColor : [UIColor colorWithWhite:1 alpha:1];
    _btnEndColor = _segmentEndColor ? _segmentEndColor : [UIColor colorWithWhite:1 alpha:0.7];
    _btnTitleFont = _segmentTitleFont ? _segmentTitleFont :[UIFont systemFontOfSize:18];
    [self addSegementLine:_segments];
    [self addSegments:_segments];
    //根据 selectedSegmentIndex 设置选中的按钮
    UIButton *segmentBtn = _segmentBtnArray[_selectedSegmentIndex];
    segmentBtn.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [self selectBtn:segmentBtn];
    //根据 selectedSegmentIndex 设置滑块的位置
    CGRect frame = _indicatorView.frame;
    frame.origin.x = (WIDTH /_segments.count) * _selectedSegmentIndex;
    _indicatorView.frame = frame;
}

//初始化滑块
- (void)addSegementLine:(NSArray*)segments {
    
    _indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0,HEIGHT - _indicatorViewHeight,
                                                               WIDTH /segments.count, _indicatorViewHeight)];
    _indicatorView.backgroundColor = _indicatorColor ? _indicatorColor : [UIColor whiteColor];
    [self addSubview:_indicatorView];
}

//初始化按钮
- (void)addSegments:(NSArray*)segments {

    CGFloat segmentWidth = WIDTH / segments.count;
    for (int i = 0; i < segments.count; ++i) {
        
        _segmentBtn = [[UIButton alloc]init];
        _segmentBtn.frame = CGRectMake(i * segmentWidth, 0, segmentWidth, HEIGHT);
        _segmentBtn.tag = 1000 + i;
        _segmentBtn.titleLabel.font = _btnTitleFont;
        [_segmentBtn setTitleColor:_btnEndColor forState:UIControlStateNormal];
        [_segmentBtn setTitleColor:_btnStartColor forState:UIControlStateSelected];
        [_segmentBtn setTitle:segments[i] forState:UIControlStateNormal];
        [_segmentBtn addTarget:self action:@selector(segmentClick:)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_segmentBtn];
        [_segmentBtnArray addObject:_segmentBtn];
    }
}

//滑块动画代码
- (void)sliderAnimation:(UIScrollView*)kpScrollView {
    
    CGFloat scrollWidth = kpScrollView.frame.size.width;
    CGFloat offsetX = kpScrollView.contentOffset.x;
    CGFloat scrollX = offsetX/scrollWidth;
    CGFloat indicatorX = _indicatorView.frame.size.width * scrollX;
    
    if (offsetX >= 0 && offsetX <= scrollWidth * (_segments.count - 1)) {
        [UIView animateWithDuration:0.05 animations:^{
            _indicatorView.frame = CGRectMake(indicatorX,HEIGHT - _indicatorViewHeight,
                                             WIDTH /_segments.count,_indicatorViewHeight);
        }];
        [self segmentBtnAnimation:scrollX];
    }
}

//按钮动画的核心代码
- (void)segmentBtnAnimation:(CGFloat)scrollX {
    
    CGFloat progress;
    if (scrollX >= 1) {
        progress = scrollX - floorf(scrollX);
    }else {
        progress = scrollX;
    }
    UIButton *segmentBtn = [self viewWithTag:scrollX + 1000];
    UIButton *segmentBtn2 = [self viewWithTag:scrollX + 1001];
    CGFloat scale = INTUInterpolateCGFloat(1.05, 1.0, progress);
    CGFloat scale2 = INTUInterpolateCGFloat(1.0, 1.05, progress);
    segmentBtn.transform = CGAffineTransformMakeScale(scale, scale);
    segmentBtn2.transform = CGAffineTransformMakeScale(scale2, scale2);
    segmentBtn.titleLabel.textColor = INTUInterpolateUIColor(_btnStartColor,_btnEndColor,progress);
    segmentBtn2.titleLabel.textColor = INTUInterpolateUIColor(_btnEndColor,_btnStartColor,progress);
}

- (void)segmentClick:(UIButton*)segmentBtn {
    
    if ([_delegate respondsToSelector:@selector(segmentClick:)]) {
        [_delegate segmentClick:segmentBtn.tag];
    }
}

//在这里设置按钮选中和未选中的状态切换
- (void)selectBtn:(UIButton*)selectBtn {
    
    if (_selectedBtn) {
        _selectedBtn.selected = NO;
    }
    _selectedBtn = selectBtn;
    _selectedBtn.selected = YES;

}
@end
