//
//  NSDate+YBSCalendar.h
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/11.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YBSCalendar)

/// 获得当前 NSDate 对象对应的日子
- (NSInteger)ybs_dateDay;

/// 获得当前 NSDate 对象对应的月份
- (NSInteger)ybs_dateMonth;

/// 获得当前 NSDate 对象对应的年份
- (NSInteger)ybs_dateYear;

/// 获得当前 NSDate 对象的上个月的某一天（此处定为15号）的 NSDate 对象
- (NSDate *)ybs_previousMonthDate;

/// 获得当前 NSDate 对象的下个月的某一天（此处定为15号）的 NSDate 对象
- (NSDate *)ybs_nextMonthDate;

/// 获得当前 NSDate 对象对应的月份的总天数
- (NSInteger)ybs_totalDaysInMonth;

/// 获得当前 NSDate 对象对应月份当月第一天的所属星期
- (NSInteger)ybs_firstWeekDayInMonth;

@end
