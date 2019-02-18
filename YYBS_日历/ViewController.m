//
//  ViewController.m
//  YYBS_日历
//
//  Created by 严兵胜 on 2019/2/18.
//  Copyright © 2019 严兵胜. All rights reserved.
//

#import "ViewController.h"
#import "YBSCalendarView.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 日历
    YBSCalendarView *calendarView = [[YBSCalendarView alloc] initWithFrame:CGRectMake(0,88,self.view.bounds.size.width, 0)];
    calendarView.lastMonthTitleColor = [UIColor lightGrayColor];
    calendarView.nextMonthTitleColor = calendarView.lastMonthTitleColor;
    calendarView.todayTitleColor = UIColorFromRGB(0x7cadf5);
    calendarView.selectBackColor = UIColorFromRGB(0xf9635b);
    calendarView.selectTitleColor = [UIColor whiteColor];
    calendarView.needToSignDateColor = calendarView.todayTitleColor;
    calendarView.needToSignTitleColor = [UIColor whiteColor];
    calendarView.titleSecondColor = UIColorFromRGB(0xffad38);
    calendarView.titleFontFloat = 13;
    calendarView.haveAnimationBool = true;
    calendarView.seleLastTimeDateBool = true;
    [calendarView dealData];
    
    [self.view addSubview:calendarView];
    
    // 需要被标记的时间
    calendarView.needToSignDateArray = @[[self ybs_stringToDateOringStr:@"2019.2.01" dateFormatter:@"yyyy.MM.dd"],
                                         [self ybs_stringToDateOringStr:@"2019.2.15" dateFormatter:@"yyyy.MM.dd"],
                                         [self ybs_stringToDateOringStr:@"2019.2.22" dateFormatter:@"yyyy.MM.dd"],
                                         [self ybs_stringToDateOringStr:@"2019.3.14" dateFormatter:@"yyyy.MM.dd"]];
    
    // 需要被二次标记的时间
    calendarView.needToSecondDateArray = @[[self ybs_stringToDateOringStr:@"2019.2.17" dateFormatter:@"yyyy.MM.dd"],
                                         [self ybs_stringToDateOringStr:@"2019.3.15" dateFormatter:@"yyyy.MM.dd"],
                                         [self ybs_stringToDateOringStr:@"2019.4.22" dateFormatter:@"yyyy.MM.dd"],
                                         [self ybs_stringToDateOringStr:@"2019.2.14" dateFormatter:@"yyyy.MM.dd"]];
    
}


- (NSDate *)ybs_stringToDateOringStr:(NSString *)dateString dateFormatter:(NSString *)formatter{
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:formatter];
    NSDate* destDate = [dateFormatter dateFromString:dateString];
    return destDate;
    
    
    
    
}


@end
