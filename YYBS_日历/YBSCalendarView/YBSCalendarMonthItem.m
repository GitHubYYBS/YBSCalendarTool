//
//  YBSCalendarMonthItem.m
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/11.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import "YBSCalendarMonthItem.h"
#import "NSDate+YBSCalendar.h"

@implementation YBSCalendarMonthItem

- (instancetype)initWithDate:(NSDate *)date {
    
    if (self = [super init]) {
        
        _monthDate = date;
        
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        
    }
    
    return self;
}



- (NSInteger)setupTotalDays {
    return [_monthDate ybs_totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday {
    return [_monthDate ybs_firstWeekDayInMonth];
}

- (NSInteger)setupYear {
    return [_monthDate ybs_dateYear];
}

- (NSInteger)setupMonth {
    return [_monthDate ybs_dateMonth];
}





@end
