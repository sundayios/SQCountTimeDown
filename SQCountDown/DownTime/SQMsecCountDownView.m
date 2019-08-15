//
//  ZWMsecCountDownView.m
//  Ymd
//
//  Created by yunmian on 2019/6/6.
//  Copyright © 2019 云免. All rights reserved.
//

#import "SQMsecCountDownView.h"
#import "SQCountDown.h"

@interface SQMsecCountDownView ()
{
    CGFloat                 passTime;
    SQCountDown               *countDown;
    
    UIView                  *countDownContaiView;
    UILabel                 *startLabel;
    
    NSMutableArray          *dateViews;
    NSMutableArray          *placeholderViews;
    NSArray                 *placeholders;
    BOOL                    recordNofication;
}
@property(nonatomic, assign)double timeInterval;
@end

@implementation SQMsecCountDownView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initUI];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self initUI];
    }
    return self;
}


- (void)initUI {
    dateViews = [NSMutableArray arrayWithCapacity:5];
    placeholderViews = [NSMutableArray arrayWithCapacity:4];
    placeholders = @[@"天", @"时", @"分",@"秒"];
    _timeNorColor = [UIColor whiteColor];
    _timeGrayColor = [UIColor blackColor];
    _timeBackGroundColor = [UIColor grayColor];
    _timeBackGroundGrayColor = [UIColor grayColor];
    _indecatorTextColor = [UIColor blackColor];
    _indecatorTextGrayColor = [UIColor blackColor];
    _indecatorBackGroudColor = [UIColor clearColor];
    _indecatorText = @"剩余";
    
    passTime = 0.0;
    countDown = [[SQCountDown alloc] init];
    
    countDownContaiView = [[UIView alloc] init];
    [self addSubview:countDownContaiView];
    
    startLabel = [[UILabel alloc] init];
    startLabel.text = @"剩余";
    startLabel.textColor = [UIColor blackColor];
    startLabel.font = [UIFont systemFontOfSize:14];
    [countDownContaiView addSubview:startLabel];
    
    for (NSInteger i = 0; i < 5; i++) {
        UILabel *countDownLabel = [[UILabel alloc] init];
        countDownLabel.text = @"00";
        
        
        countDownLabel.textAlignment = NSTextAlignmentCenter;
        if (i != 0) {
            countDownLabel.font = [UIFont systemFontOfSize:14];
            countDownLabel.textColor = self.timeNorColor;
            countDownLabel.backgroundColor = self.timeBackGroundColor;
            countDownLabel.layer.cornerRadius = 2;
            countDownLabel.clipsToBounds = YES;
        }else {
            countDownLabel.font = [UIFont systemFontOfSize:14];
            countDownLabel.textColor = self.timeNorColor;
            countDownLabel.backgroundColor = self.timeBackGroundColor;
        }
        [countDownContaiView addSubview:countDownLabel];
        [dateViews addObject:countDownLabel];
    }
    
    for (NSInteger i = 0; i < placeholders.count; i++) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.text = placeholders[i];
        placeholderLabel.textColor = self.indecatorTextColor;
        placeholderLabel.font = [UIFont systemFontOfSize:14];
        placeholderLabel.textAlignment = NSTextAlignmentCenter;
        [countDownContaiView addSubview:placeholderLabel];
        [placeholderViews addObject:placeholderLabel];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [countDownContaiView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.height.offset(13.5);
        make.width.equalTo(self);
    }];
    
    [startLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->countDownContaiView.mas_left).offset(2);
        make.top.bottom.equalTo(self->countDownContaiView);
        make.width.offset(35);
    }];
    
    UILabel *lastCountdownLabel;
    for (NSInteger i = 0; i < dateViews.count; i++) {
        UILabel *countdownLabel = (UILabel *)dateViews[i];
        [countdownLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (lastCountdownLabel) {
                if (i == 1) {
                    make.left.equalTo(lastCountdownLabel.mas_right).offset(18);
                }else {
                    make.left.equalTo(lastCountdownLabel.mas_right).offset(15);
                }
            }else {
                make.left.equalTo(self->startLabel.mas_right);
            }
            if (i - 1 == dateViews.count) {
                make.size.mas_equalTo(CGSizeMake(15, 15));
            }else {
                make.size.mas_equalTo(CGSizeMake(20, 15));
            }
            make.centerY.equalTo(self->startLabel);
        }];
        
        lastCountdownLabel = countdownLabel;
        
        if (i >= placeholderViews.count) {
            return;
        }
        UILabel *placeholderLabel = (UILabel *)placeholderViews[i];
        [placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(countdownLabel.mas_right);
            make.centerY.equalTo(countdownLabel);
            make.size.mas_equalTo(CGSizeMake(15, 12));
        }];
    }
}


- (NSDate *)getGoodsExpireDate1:(NSInteger)expire startTime:(NSString *)startTime {
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [format dateFromString:startTime];
    
    //    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    if(expire!=0){
        
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [startDate initWithTimeInterval:oneDay * expire sinceDate:startDate ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
        
    }else{
        
        theDate = startDate;
    }
    return theDate;
}
- (void)countdownWithExpire:(NSInteger)expire startTime:(NSString *)startTime {
    
    NSDate *time = [self getGoodsExpireDate1:expire startTime:startTime];
    
    
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[time timeIntervalSince1970]] integerValue]*1000;
    self.timeInterval = timeSp;
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //获取当前系统的时间，并用相应的格式转换
    [dataFormatter stringFromDate:[NSDate date]];
    NSString *currentDayStr = [dataFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dataFormatter dateFromString:currentDayStr];
    
    //优惠结束的时间，也用相同的格式去转换
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timeInterval/1000.0];
    NSString *deadlineStr = [dataFormatter stringFromDate:date];
    NSDate *deadlineDate = [dataFormatter dateFromString:deadlineStr];
    
    self.timeInterval = [deadlineDate timeIntervalSinceDate:currentDate]*1000;
    
//    kWeakSelf(self);
  __weak typeof(self) weakSelf = self;
    [countDown countDownWithPER_MSECBlock:^{
        [weakSelf updateTime];
    }];
}

#pragma mark Private
- (void)updateTime {
    
    passTime += 100.f;//毫秒数从0-9，所以每次过去100毫秒
    
    // (timeInterval/(3600*24));
    // ((timeInterval-days*24*3600)/3600 + (days * 24))
    //
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:5];
    
    NSInteger day = (NSInteger)((self.timeInterval -passTime)/ 1000 / 60 / 60) / 24;
    NSString *dayStr = [NSString stringWithFormat:@"%ld", day];
    
    NSInteger hours = (NSInteger)((self.timeInterval-passTime)/1000/60/60)%24;
    NSString *hoursStr= [NSString stringWithFormat:@"%ld", hours];
    
    NSInteger minute = (NSInteger)((self.timeInterval-passTime)/1000/60)%60;
    NSString *minuteStr = [NSString stringWithFormat:@"%ld", minute];
    
    NSInteger second = ((NSInteger)(self.timeInterval-passTime))/1000%60;
    NSString *secondStr = [NSString stringWithFormat:@"%ld", second];
    //毫秒数
    CGFloat sss = ((NSInteger)((self.timeInterval - passTime)))%1000/100;
    NSString *ss = [NSString stringWithFormat:@"%.lf", sss];
    
    if (day < 10) {
        dayStr = [NSString stringWithFormat:@"0%ld", day];
    }
    
    if (hours < 10) {
        hoursStr = [NSString stringWithFormat:@"0%ld", hours];
    }
    
    if (minute < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld", minute];
    }
    
    if (second < 10) {
        secondStr = [NSString stringWithFormat:@"0%ld", second];
    }
    
    [tempArray addObjectsFromArray:@[dayStr, hoursStr, minuteStr, secondStr, ss]];
    
    if (day <=0 && hours <= 0 && minute <=0 && second <= 0) {
        for (NSInteger i = 0; i < dateViews.count; i++) {
            UILabel *countDownLabel = (UILabel *)dateViews[i];
            countDownLabel.text = @"00";
            countDownLabel.textColor = self.timeGrayColor;
            if (i != 0) {
                countDownLabel.backgroundColor = self.timeBackGroundGrayColor;
            }else{
                countDownLabel.backgroundColor = self.timeBackGroundGrayColor;
            }
        }
        [countDown destoryTimer];
        if (self.isTimeOutHidden) {
            self.hidden = YES;
        }
        
        if (self.isNofication) {
            if (recordNofication) {
                [[NSNotificationCenter defaultCenter] postNotificationName:YmdCountDownNofication object:nil];
                recordNofication = NO;
            }else{
                recordNofication = YES;
            }
        }
        
    }else {
        for (NSInteger i = 0; dateViews.count == tempArray.count && i < tempArray.count; i++) {
            UILabel *countDownLabel = (UILabel *)dateViews[i];
            countDownLabel.text = tempArray[i];
            countDownLabel.textColor = self.timeNorColor;
            if (i != 0) {
                countDownLabel.backgroundColor = self.timeBackGroundColor;
            }else{
                countDownLabel.backgroundColor = self.timeBackGroundColor;
            }
        }
    }
}
@end
