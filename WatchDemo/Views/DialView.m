//
//  DialElementView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "DialView.h"
#import "DialElement.h"
@implementation DialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame];
        [self initNumber:frame];
    }
    return self;
}

#pragma mark - 表盘刻度
- (void)initView:(CGRect)frame
{
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat angle = 0;
    for (int i = 0; i < 30; i++)
    {
        DialElement *element = [[DialElement alloc]
                                initWithFrame:CGRectMake(frame.size.width/2 - 1,
                                                         0,
                                                         2,
                                                         frame.size.height)
                                withInt:i];
        element.backgroundColor = [UIColor blackColor];
        element.transform = CGAffineTransformMakeRotation(angle);
        [self addSubview:element];
        angle+=M_PI/180*6;
    }
}

#pragma mark - 表盘数字
- (void)initNumber:(CGRect)frame
{
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0, 0, 20, 20);
    label1.text = @"12";
    label1.center = CGPointMake(frame.size.width/2, 15);
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 0, 20, 20);
    label2.text = @"3";
    label2.center = CGPointMake(frame.size.width - 10, frame.size.height/2);
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(0, 0, 20, 20);
    label3.text = @"6";
    label3.center = CGPointMake(frame.size.width/2 + 5, frame.size.height - 15);
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(0, 0, 20, 20);
    label4.text = @"9";
    label4.center = CGPointMake(20, frame.size.height/2);
    
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:label4];
}

@end
