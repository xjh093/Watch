//
//  TimeSourceModel.m
//  Timer
//
//  Created by Lightech on 15-6-2.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import "TimeSourceModel.h"

@implementation TimeSourceModel

- (id)init
{
    self = [super init];
    if (self) {
        _timeArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - 获取时间数组-get time array
- (NSMutableArray *)timeArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *timeString = [self getTimeString];
    
    array = [self getTimeArray:timeString];
    
    return array;
}

#pragma mark - 获取时间字符串-get the time string
- (NSString *)getTimeString
{
    //+1是因为定时器取的数据是前1秒的
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    NSString *timeString = [formatter stringFromDate:date];
    
    return timeString;
}

#pragma mark - 获取时分秒-get hour,minute,second
- (NSMutableArray *)getTimeArray:(NSString *)timeString
{
    NSArray *array = [timeString componentsSeparatedByString:@":"];
    
    NSString *hours = array[0];
    NSString *minutes = array[1];
    NSString *seconds = array[2];
    
    NSString *hourStr1 = [hours substringToIndex:hours.length - 1];
    NSString *hourStr2 = [hours substringFromIndex:hours.length - 1];
    NSString *minuteStr1 = [minutes substringToIndex:minutes.length - 1];
    NSString *minuteStr2 = [minutes substringFromIndex:minutes.length - 1];
    NSString *secondStr1 = [seconds substringToIndex:seconds.length - 1];
    NSString *secondStr2 = [seconds substringFromIndex:seconds.length - 1];
    
    NSMutableArray *timeArray = [NSMutableArray array];
    [timeArray addObject:hourStr1];
    [timeArray addObject:hourStr2];
    [timeArray addObject:minuteStr1];
    [timeArray addObject:minuteStr2];
    [timeArray addObject:secondStr1];
    [timeArray addObject:secondStr2];
    
    return timeArray;
}

@end


























