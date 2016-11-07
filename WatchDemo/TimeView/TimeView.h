//
//  TimeView.h
//  Timer
//
//  Created by Lightech on 15-6-1.
//  Copyright (c) 2015年 Lightech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeView : UIView

/**
 *@brief 具体的动画形式
 */
@property (nonatomic,retain) NSString *animation;

- (id)initWithFrame:(CGRect)frame andFont:(CGFloat)fontSize;
@end
