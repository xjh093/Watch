//
//  AddNotificationView.m
//  WatchDemo
//
//  Created by Lightech on 15-6-26.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "AddNotificationView.h"

@interface AddNotificationView ()<UIActionSheetDelegate>
@property(strong,nonatomic)UIDatePicker *datePick;
@property(strong,nonatomic)UIButton *button;
@property(strong,nonatomic)UIView *hideView;
@property(assign,nonatomic)CGRect rect;
@end
@implementation AddNotificationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    //标题 - 添加提醒
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 20, rect.size.width, 30);
    label.text = @"添加提醒";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    
    //提醒时间
    //提醒内容
    //是否重复
    NSArray *titleArray = @[@"提醒时间",@"提醒内容",@"是否重复"];
    for (int i = 0; i < titleArray.count; i++)
    {
        UITextField *textField = [[UITextField alloc] init];
        textField.frame = CGRectMake(2,
                                     label.frame.origin.y+label.frame.size.height * (i + 1),
                                     label.frame.size.width - 4,
                                     label.frame.size.height);
        textField.text = titleArray[i];
        textField.tag = 101 + i;
        textField.clearsOnBeginEditing = YES;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:textField];
        
        if (0 == i)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = textField.frame;
            [button addTarget:self
                       action:@selector(didClick1)
             forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        else if (2 == i)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = textField.frame;
            [button addTarget:self
                       action:@selector(didClick2)
             forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        else
        {
            textField.enabled = YES;
        }
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(2, 145, rect.size.width - 4, 30);
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 4;
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(didClick3)
     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}

#pragma mark - 时间选择
- (void)didClick1
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    UIDatePicker *datePick = [[UIDatePicker alloc] init];
    datePick.frame = CGRectMake(0,
                                rect.size.height - 201,
                                rect.size.width,
                                162);//此一般都为横向320*216像素，纵向为480*162像素。
    datePick.datePickerMode = UIDatePickerModeDateAndTime;
    datePick.backgroundColor = [UIColor lightGrayColor];
    datePick.layer.masksToBounds = YES;
    datePick.layer.cornerRadius = 4.0;
    _datePick = datePick;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(datePick.frame.origin.x,
                               datePick.frame.origin.y + datePick.frame.size.height,
                               datePick.frame.size.width,
                               40);
    button1.exclusiveTouch = YES;
    button1.backgroundColor = [UIColor whiteColor];
    [button1 setTitle:@"确认" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(getDate:) forControlEvents:UIControlEventTouchUpInside];
    _button = button1;
    
    [self.window addSubview:_datePick];
    [self.window addSubview:button1];
}

- (void)getDate:(UIButton *)button
{
    NSDate *date = [_datePick date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    UITextField *textField = (UITextField *)[self viewWithTag:101];
    textField.text = dateString;
    
    [_datePick removeFromSuperview];
    [button removeFromSuperview];
}

#pragma mark - 是否重复
- (void)didClick2
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"不重复"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"每天重复",@"每周重复",@"每月重复",@"每年重复", nil];
    
    [actionSheet showInView:self];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    NSLog(@"%ld",buttonIndex);
    //buttonIndex,从上往下,0到4

    NSArray *array = @[@"每天重复",@"每周重复",@"每月重复",@"每年重复",@"不重复"];
    NSString *string = array[buttonIndex];
    UITextField *textField = (UITextField *)[self viewWithTag:103];
    textField.text = string;
}

#pragma mark - 确定
- (void)didClick3
{
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    //设置调用时间
    //通知触发时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    UITextField *textField = (UITextField *)[self viewWithTag:101];
    NSDate *date = [dateFormatter dateFromString:textField.text];
    notification.fireDate = date;
    
    //设置通知属性
    //通知主体
    UITextField *textField2 = (UITextField *)[self viewWithTag:102];
    notification.alertBody = textField2.text;
    
    //通知重复次数
    UITextField *textField3 = (UITextField *)[self viewWithTag:103];
    NSArray *array = @[@"每天重复",@"每周重复",@"每月重复",@"每年重复",@"不重复"];
    NSInteger index = [array indexOfObject:textField3.text];
    switch (index) {
        case 0:
            notification.repeatInterval = NSCalendarUnitDay;
            break;
        case 1:
            notification.repeatInterval = NSCalendarUnitDay;
            break;
        case 2:
            notification.repeatInterval = NSCalendarUnitMonth;
            break;
        case 3:
            notification.repeatInterval = NSCalendarUnitYear;
            break;
        default:
            notification.repeatInterval = 0;
            break;
    }
    notification.repeatInterval = 2;
    
    //当前日历，使用前最好设置时区等信息以便能够自动同步时间
    //notification.repeatCalendar=[NSCalendar currentCalendar];
    
    //应用程序图标右上角显示的消息数
    notification.applicationIconBadgeNumber = 1;
    
    //待机界面的滑动动作提示
    notification.alertAction = @"打开应用";
    
    //通过点击通知打开应用时的启动图片，这里使用程序启动图片
    notification.alertLaunchImage = @"Default";
    
    //收到通知时播放的声音，默认消息声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    
    //通知声音(需要真机才能听到声音)
    notification.soundName = @"msg.caf";
    
    //设置用户信息
    //绑定到通知上的其他附加信息
    notification.userInfo = @{@"id":@1,@"user":@"Haomissyou"};
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    [_hideView removeFromSuperview];
    [self removeFromSuperview];
}

- (void)showInView:(UIView *)view
{
    UIView *hideView = [[UIView alloc] init];
    hideView.frame = view.frame;
    hideView.backgroundColor = [UIColor lightGrayColor];
    hideView.alpha = 0.3;
    _hideView = hideView;
    [view addSubview:_hideView];

    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(didTap1)];
    [hideView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(didTap2)];
    tap2.numberOfTapsRequired = 2;
    [hideView addGestureRecognizer:tap2];
    
    //避免tap1与tap2冲突
    [tap1 requireGestureRecognizerToFail:tap2];
    
    [view addSubview:self];
    
    _rect = self.frame;
    self.frame = CGRectMake(0, -_rect.size.height, _rect.size.width, _rect.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = _rect;
    }];
}

#pragma mark - 退出编辑状态
- (void)didTap1
{
    [self endEditing:YES];
}

#pragma mark - 退出添加提醒
- (void)didTap2
{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, -_rect.size.height, _rect.size.width, _rect.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [_hideView removeFromSuperview];
    [_datePick removeFromSuperview];
    [_button removeFromSuperview];
}

@end



























