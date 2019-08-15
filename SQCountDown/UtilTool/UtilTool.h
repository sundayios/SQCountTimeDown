//
//  UtilTool.h
//  SQCountDown
//
//  Created by yunmian on 2019/8/15.
//  Copyright © 2019 James. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UtilTool : NSObject


+ (NSDate *)getGoodsExpireDate1:(NSInteger)expire startTime:(NSString *)startTime;
+ (NSDate *)getGoodsExpireDate:(NSInteger)expire startTime:(NSString *)startTime;
@end

NS_ASSUME_NONNULL_END
