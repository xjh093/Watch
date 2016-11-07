//
//  DialElement.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "DialElement.h"

@implementation DialElement

- (instancetype)initWithFrame:(CGRect)frame withInt:(int)index
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView:frame index:index];
    }
    return self;
}

- (void)initView:(CGRect)frame index:(int)index
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *view1 = [[UIView alloc] init];
    UIView *view2 = [[UIView alloc] init];
    
    if (0 == index%5)
    {
        view1.frame = CGRectMake(0,
                                 0,
                                 frame.size.width,
                                 frame.size.width + 6);
        
        view2.frame = CGRectMake(0,
                                 frame.size.height - frame.size.width - 6,
                                 frame.size.width,
                                 frame.size.width + 6);
    }
    else
    {
        view1.frame = CGRectMake(0,
                                 0,
                                 frame.size.width,
                                 frame.size.width + 2);

        view2.frame = CGRectMake(0,
                                 frame.size.height - frame.size.width - 2,
                                 frame.size.width,
                                 frame.size.width + 2);
    }
    
    view1.backgroundColor = [UIColor blackColor];
    view2.backgroundColor = view1.backgroundColor;
    [self addSubview:view1];
    [self addSubview:view2];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (![[UIColor clearColor] isEqual:backgroundColor]) {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
