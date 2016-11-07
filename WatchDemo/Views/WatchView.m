//
//  WatchView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-18.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "WatchView.h"
#import "DialView.h"
#import "SecondHandView.h"
#import "TimeView.h"
#import "AddNotificationView.h"

@interface WatchView ()
@property(strong,nonatomic)SecondHandView *hourView;
@property(strong,nonatomic)SecondHandView *minuteView;
@property(strong,nonatomic)SecondHandView *secondView;
@property(assign,nonatomic)CGFloat hourAngle;
@property(assign,nonatomic)CGFloat minuteAngle;
@property(assign,nonatomic)CGFloat secondAngle;
@property(strong,nonatomic)NSTimer *timer;
@end
@implementation WatchView

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
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = frame.size.width/2;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [[UIColor brownColor] CGColor];
    
    [self addTapGesture];
    [self registerNotifecation];
    [self initDialView:frame];
    [self initTimeView:frame font:fontSize];
    [self initSecondView:frame];
    [self setSecondHandAngle];
    [self fireTheTimer];
}

#pragma mark - 添加单击、双击手势
- (void)addTapGesture
{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(didTap)];
    [self addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(doubleTap)];
    //两指点击
    tap2.numberOfTouchesRequired = 2;
    
    //双击
//    tap2.numberOfTapsRequired = 2;
    
    //避免tap1与tap2冲突
    [tap1 requireGestureRecognizerToFail:tap2];
    
    [self addGestureRecognizer:tap2];
}

- (void)didTap
{
    UIColor *color = self.backgroundColor;
    if ([color isEqual:[UIColor lightGrayColor]])
    {
        self.backgroundColor = [UIColor clearColor];
    }
    else
    {
        self.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)doubleTap
{
    AddNotificationView *view = [[AddNotificationView alloc] init];
    view.frame = CGRectMake(0, 0, 320, 180);
    view.backgroundColor = [UIColor lightGrayColor];
//    [self.window addSubview:view];
    [view showInView:self.window];
}

#pragma mark - 注册通知
- (void)registerNotifecation
{
    //进入前台，重新设置针的角度
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    //进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)enterForeground
{
    [self setSecondHandAngle];
    _timer.fireDate = [NSDate distantPast];
}

- (void)enterBackground
{
    _timer.fireDate = [NSDate distantFuture];
}

#pragma mark - 表盘
- (void)initDialView:(CGRect)frame
{
    DialView *dialView = [[DialView alloc]
                          initWithFrame:CGRectMake(2,
                                                   2,
                                                   frame.size.width - 4,
                                                   frame.size.height - 4)];
    [self addSubview:dialView];
}

#pragma mark - 数字时钟
- (void)initTimeView:(CGRect)frame font:(CGFloat)fontSize
{
//    @"fade",@"push",@"reveal",@"oglFlip",
//    @"rippleEffect",@"pageCurl",@"pageUnCurl",@"cube"
    
    CGFloat width = frame.size.width*0.727273;
    CGFloat height = frame.size.height*0.181819;
    
    TimeView *timeView = [[TimeView alloc]
                          initWithFrame:CGRectMake(0, 0, width, width/3.2)
                          andFont:fontSize];
    timeView.center = CGPointMake(frame.size.width/2, frame.size.height/2 - height);
    timeView.animation = @"rippleEffect";
    [self addSubview:timeView];
}

#pragma mark - 时针、分针、秒针
- (void)initSecondView:(CGRect)frame
{
    NSArray *colorArray = @[[UIColor blueColor],[UIColor greenColor],[UIColor redColor]];
    NSMutableArray *handViewArray = [NSMutableArray array];
    for (int i = 0; i < colorArray.count; i++)
    {
        SecondHandView *handView = [[SecondHandView alloc]
                                    initWithFrame:CGRectMake(frame.size.width/2 - 1,
                                                             5,
                                                             2,
                                                             frame.size.height - 10)];
        handView.handColor = colorArray[i];
        [handViewArray addObject:handView];
        [self addSubview:handView];
    }
    
    _hourView = handViewArray[0];   //时针
    _minuteView = handViewArray[1]; //分针
    _secondView = handViewArray[2]; //秒针
}

#pragma mark - 设置时针、分针、秒针的角度
- (void)setSecondHandAngle
{
    //+1是因为定时器取的数据是前1秒的
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *timeString = [formatter stringFromDate:date];
    NSArray *array = [timeString componentsSeparatedByString:@":"];
    
    NSString *hours = array[0];
    NSString *minutes = array[1];
    NSString *seconds = array[2];
    
    _hourAngle = hours.intValue * (M_PI/180*6*5);
    _minuteAngle = minutes.intValue * (M_PI/180*6);
    _secondAngle = seconds.intValue * (M_PI/180*6);
    
    while (_hourAngle > 6.283185)
    {
        _hourAngle -= 6.283185;
    }
    //NSLog(@"%@-%f",hours,_hourAngle);
    //NSLog(@"%@-%f",minutes,_minuteAngle);
    //NSLog(@"%@-%f",seconds,_secondAngle);
    
    //分针走一圈-360度，时针走30度
    //分钟走一格-6度，时针走0.5度
    _hourAngle += minutes.intValue*(M_PI/180/2);
    //NSLog(@"%@-%f",hours,_hourAngle);
    
    _hourView.transform = CGAffineTransformMakeRotation(_hourAngle);
    _minuteView.transform = CGAffineTransformMakeRotation(_minuteAngle);
    _secondView.transform = CGAffineTransformMakeRotation(_secondAngle);
}

#pragma mark - 启动定时器
- (void)fireTheTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(resetSecondAngle)
                                                    userInfo:nil
                                                     repeats:YES];
    _timer = timer;
    [_timer fire];
}

#pragma mark - 重置秒针的角度
- (void)resetSecondAngle
{
    [UIView animateWithDuration:0.9 animations:^{
        _secondView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _secondView.transform = CGAffineTransformMakeRotation(_secondAngle);
    }];
    if (_secondAngle >= 6.283185)
    {
        _secondAngle = M_PI/180*6;
        [self resetMinuteAngle];
    }
    else
    {
        _secondAngle+=M_PI/180*6;
    }
    
    /**
     *秒针走一圈-360度，分针走6度
     *分针走一圈-360度，时针走30度
     *秒:分:时 = 360:6:0.5 = 720:12:1
     *秒针走1度-M_PI/180 : 1:12/720:1/720
     */
}

#pragma mark - 重置分针的角度
- (void)resetMinuteAngle
{
    if (_minuteAngle >= 6.283185)
    {
        _minuteAngle = M_PI/180*6;
    }
    else
    {
        _minuteAngle +=M_PI/180*6;
    }
    [UIView animateWithDuration:0.7 animations:^{
        _minuteView.transform = CGAffineTransformMakeRotation(_minuteAngle);
    }];
    
    [self resetHourAngle];
}

#pragma mark - 重置时针的角度
- (void)resetHourAngle
{
    if (_hourAngle >= 6.283185)
    {
        _hourAngle = M_PI/180*6/12;
    }
    else
    {
        //1度=M_PI/180
        //分针走一圈-360度，时针走30度
        //分钟走一格-6度，时针走0.5度, 6:0.5 = 60:5 = 12 : 1
        _hourAngle +=M_PI/180*6/12;
    }
    [UIView animateWithDuration:0.7 animations:^{
        _hourView.transform = CGAffineTransformMakeRotation(_hourAngle);
    }];
    
    //NSLog(@"h-%f",_hourAngle);
    //NSLog(@"m-%f",_minuteAngle);
    //NSLog(@"s-%f",_secondAngle);
}

@end
















