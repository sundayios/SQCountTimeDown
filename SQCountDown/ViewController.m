//
//  ViewController.m
//  SQCountDown
//
//  Created by yunmian on 2019/8/15.
//  Copyright © 2019 James. All rights reserved.
//

#import "ViewController.h"

#import "SQCountDown.h"
#import "SQMsecCountDownView.h"

@interface ViewController ()
@property (nonatomic, strong) SQCountDown *countDown;
@property (weak, nonatomic) IBOutlet SQMsecCountDownView *msecCountDownView;

@property (strong, nonatomic) IBOutlet UILabel *lbCountDown;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    
    self.msecCountDownView.backgroundColor = [UIColor whiteColor];
    self.msecCountDownView.timeBackGroundColor = [UIColor redColor];
    self.msecCountDownView.timeGrayColor = [UIColor blackColor];
    self.msecCountDownView.timeBackGroundColor = [UIColor grayColor];
    self.msecCountDownView.indecatorText = @"提示倒计时";
    self.msecCountDownView.indecatorTextColor = [UIColor blackColor];
    self.msecCountDownView.indecatorTextGrayColor = [UIColor grayColor];
    self.msecCountDownView.indecatorBackGroudColor = [UIColor purpleColor];
    self.msecCountDownView.timeNorColor = [UIColor whiteColor];
    [self.msecCountDownView countdownWithExpire:3 startTime:@"2019-8-10 12:30:30"];
    
    [self addObserver];
    
}

#pragma mark - Notification
- (void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(msecCountNotification:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)msecCountNotification:(NSNotification *)nofication{
    //隐藏
    self.msecCountDownView.hidden = YES;
}

- (void)dealloc{
    [self removeObserver];
}

//设置纯字符串
- (void)countDownString{
    [self.countDown countDownStartateStr:@"2019-8-15 12:30:30" expirationDays:3 completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSString *timerShow;
        __weak typeof(self) weakSelf = self;
        
        if (day > 0 || hour > 0 || minute > 0 || second > 0) {
            if (day > 0) {
                timerShow = [NSString stringWithFormat:@"剩余%ld天%ld时%ld分%ld秒",day,hour,minute,second];
                
            }else if(hour > 0){
                timerShow = [NSString stringWithFormat:@"剩余%ld时%ld分%ld秒",hour,minute,second];
            }else if (minute > 0){
                timerShow = [NSString stringWithFormat:@"剩余%ld分%ld秒",minute,second];
            }else{
                timerShow = [NSString stringWithFormat:@"剩余%ld秒",second];
            }
            dispatch_queue_t queueMain = dispatch_get_main_queue();
            
            //2.异步任务
            dispatch_async(queueMain, ^{
                weakSelf.lbCountDown.text = [NSString stringWithFormat:@"%@\n邀请好友接力（仅差%@人）",timerShow,[YmdTool converDigitail2Han:self.activeModel.dominosNum - self.activeModel.recordList.count]];
            });
            
        }else{
            
            
            dispatch_queue_t queueMain = dispatch_get_main_queue();
            
            //2.异步任务
            dispatch_async(queueMain, ^{
                __weak typeof(self) weakSelf = self;
               weakSelf.lbCountDown.text = @"倒计时完成";
            });
        }
        
        
    }];
}



- (IBAction)btnClick:(id)sender {
    [self countDownString];
}


@end
