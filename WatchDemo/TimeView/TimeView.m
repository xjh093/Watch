//
//  TimeView.m
//  Timer
//
//  Created by Lightech on 15-6-1.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "TimeView.h"
#import "TimeElement.h"
#import "TimeSourceModel.h"

@interface TimeView ()

@property(nonatomic,retain)NSMutableArray *elementArray;

@end
@implementation TimeView

- (id)initWithFrame:(CGRect)frame andFont:(CGFloat)fontSize
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame font:fontSize];
        [self fireTheTimer];
    }
    return self;
}

#pragma mark - init
- (void)initView:(CGRect)frame font:(CGFloat)fontSize
{
    //self.backgroundColor = [UIColor brownColor];
    
    _elementArray = [NSMutableArray array];
    CGFloat width = frame.size.width/5;
    
    for (int i = 0; i < 3; i++)
    {
        TimeElement *element1 = [[TimeElement alloc]
                                initWithFrame:CGRectMake(1.8*width*i,
                                                         5,
                                                         width - 10,
                                                         frame.size.height - 10) andFont:fontSize];
        TimeElement *element2 = [[TimeElement alloc]
                                initWithFrame:CGRectMake(element1.frame.origin.x + element1.frame.size.width + 2,
                                                         5,
                                                         element1.frame.size.width,
                                                         element1.frame.size.height) andFont:fontSize];
        [self addSubview:element1];
        [self addSubview:element2];
        [_elementArray addObject:element1];
        [_elementArray addObject:element2];
        
        if (i < 2)
        {
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(element2.frame.origin.x + element2.frame.size.width + 2,
                                     element2.frame.origin.y,
                                     10,
                                     element2.frame.size.height);
            label.text = @":";
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:fontSize - 3];
            //label.adjustsFontSizeToFitWidth = YES;
            [self addSubview:label];
        }
    }
}

#pragma mark - 启动定时器
- (void)fireTheTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(getTime)
                                                    userInfo:nil
                                                     repeats:YES];
    [timer fire];
}

#pragma mark - 获取当前时间
- (void)getTime
{
    TimeSourceModel *timeModel = [[TimeSourceModel alloc] init];
    
    NSMutableArray *array = timeModel.timeArray;

    [self updateTime:array];
}

#pragma mark - 更新时间
- (void)updateTime:(NSMutableArray *)array
{
    for (int i = 0; i < 6; i++)
    {
        TimeElement *element = _elementArray[i];
        element.animationType = _animation;
        if ([@"push" isEqualToString:_animation] || [@"reveal" isEqualToString:_animation])
        {
            element.layer.masksToBounds = YES;
        }
        
        if ([@"cube" isEqualToString:_animation] || [@"oglFlip" isEqualToString:_animation])
        {
            element.animationSubType = kCATransitionFromBottom;
        }
        else if ([@"pageCurl" isEqualToString:_animation])
        {
            element.animationSubType = kCATransitionFromLeft;
        }
        else if ([@"pageUnCurl" isEqualToString:_animation])
        {
            element.animationSubType = kCATransitionFromRight;
        }
        else if ([@"push" isEqualToString:_animation] ||
                 [@"reveal" isEqualToString:_animation])
        {
            element.animationSubType = kCATransitionFromBottom;
        }
        
        element.value = array[i];
    }
}

@end











