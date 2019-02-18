//
//  YBSCalendarMonthItem.h
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/11.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBSCalendarMonthItem : NSObject

/// 传入的 NSDate 对象，该 NSDate 对象代表当前月的某一日，根据它来获得其他数据
@property (nonatomic, strong) NSDate   *monthDate;
/// 当前月的天数
@property (nonatomic, assign) NSInteger totalDays;
/// 标示第一天是星期几（0代表周日，1代表周一，以此类推）
@property (nonatomic, assign) NSInteger firstWeekday;
/// 所属年份
@property (nonatomic, assign) NSInteger year;
/// 当前月份
@property (nonatomic, assign) NSInteger month;


- (instancetype)initWithDate:(NSDate *)date;

@end
