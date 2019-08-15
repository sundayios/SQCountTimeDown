//
//  UtilTool.m
//  SQCountDown
//
//  Created by yunmian on 2019/8/15.
//  Copyright © 2019 James. All rights reserved.
//

#import "UtilTool.h"

@implementation UtilTool



+ (NSDate *)getGoodsExpireDate1:(NSInteger)expire startTime:(NSString *)startTime {
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
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    return the_date_str;
}
+ (NSDate *)getGoodsExpireDate:(NSInteger)expire startTime:(NSString *)startTime {
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
@end
