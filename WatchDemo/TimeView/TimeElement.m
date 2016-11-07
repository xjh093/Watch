//
//  TimeElement.m
//  Timer
//
//  Created by Lightech on 15-6-1.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "TimeElement.h"

@interface TimeElement ()

@property(nonatomic,retain)UIView *timeView;
@property(nonatomic,retain)UILabel *timeLabel;
@property(nonatomic,retain)NSString *preValue;

@end

@implementation TimeElement

- (id)initWithFrame:(CGRect)frame andFont:(CGFloat)fontSize
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame font:fontSize];
    }
    return self;
}

- (void)initView:(CGRect)frame font:(CGFloat)fontSize
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    view.backgroundColor = [UIColor clearColor];
    _timeView = view;
    [self addSubview:view];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    //timeLabel.adjustsFontSizeToFitWidth = YES;
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.layer.masksToBounds = YES;
    timeLabel.layer.cornerRadius = 5;
    _timeLabel = timeLabel;
    [view addSubview:timeLabel];
}

- (void)setValue:(NSString *)value
{
    if (![_preValue isEqualToString:value])
    {
        [self transtionAnimation:value];
    }
    _preValue = value;
}

- (void)transtionAnimation:(NSString *)value
{
    //创建转场动画对象
    CATransition *transition = [[CATransition alloc] init];
    
    //设置动画类型
    //设置动画类型，注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    /*
     *公开API
     *@"fade" - kCATransitionFade
     *@"movein" - kCATransitionMoveIn
     *@"push" - kCATransitionPush
     *@"reveal" - kCATransitionReveal
     *
     *私有API
     *@"cube" - 立方体翻转效果
     *@"oglFlip" - 翻转效果
     *@"suckEffect" - 收缩效果
     *@"rippleEffect" - 水滴波纹效果
     *@"pageCurl" - 向上翻页效果
     *@"pageUnCurl" - 向下翻页效果
     *@"cameraIrisHollowOpen" - 摄像头打开效果
     *@"cameraIrisHollowClose" - 摄像头关闭效果
     */
    transition.type = _animationType;
    
    //设置子类型
    //kCATransitionFromTop,kCATransitionFromBottom,kCATransitionFromLeft,kCATransitionFromRight
    transition.subtype = _animationSubType;
    
    //设置动画时长
    transition.duration = .75f;
    
    _timeLabel.text = value;
    [_timeView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
