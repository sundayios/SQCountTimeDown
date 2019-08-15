//
//  ZWMsecCountDownView.h
//  Ymd
//
//  Created by yunmian on 2019/6/6.
//  Copyright © 2019 云免. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQMsecCountDownView : UIView
/***
 *正常显示时的颜色
 *
 **/
@property (nonatomic, strong) IBInspectable UIColor *timeNorColor;
/***
 *
 *倒计时为零时的
 **/
@property (nonatomic, strong) IBInspectable UIColor *timeGrayColor;
/***
 *正常显示时的颜色
 *
 **/
@property (nonatomic, strong) IBInspectable UIColor *timeBackGroundColor;
/***
 *
 *计时为零时的
 **/
@property (nonatomic, strong) IBInspectable UIColor *timeBackGroundGrayColor;
/***
 *正常显示时的颜色
 *
 **/
@property (nonatomic, strong) IBInspectable UIColor *indecatorTextColor;
/***
 *计时为零时的
 *
 **/
@property (nonatomic, strong) IBInspectable UIColor *indecatorTextGrayColor;
//最前边的提示文字
@property (nonatomic, copy) IBInspectable NSString *indecatorText;

//倒计时为零时的
@property (nonatomic, strong) IBInspectable UIColor *indecatorBackGroudColor;

/*****
    倒计时为零时 是否隐藏
 *****/
@property (nonatomic, assign) IBInspectable BOOL isTimeOutHidden;
/*****
 如果设置值 为true   倒计时为零时 发出通知
 *****/
@property (nonatomic, assign) IBInspectable BOOL isNofication;

- (void)countdownWithExpire:(NSInteger)expire startTime:(NSString *)startTime;


@end

NS_ASSUME_NONNULL_END
