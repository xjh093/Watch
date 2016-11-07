//
//  TimeElement.h
//  Timer
//
//  Created by Lightech on 15-6-1.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeElement : UIView
/**
 *@brief 具体的时间
 */
@property (nonatomic,retain) NSString *value;

/**
 *@brief 具体的动画
 */
@property (nonatomic,retain) NSString *animationType;

/**
 *@brief 具体的子动画
 */
@property (nonatomic,retain) NSString *animationSubType;

- (id)initWithFrame:(CGRect)frame andFont:(CGFloat)fontSize;
@end
