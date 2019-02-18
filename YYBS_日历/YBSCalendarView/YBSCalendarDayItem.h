//
//  YBSCalendarDayItem.h
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/11.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YBSCalendarDayItem : NSObject
/// 当前月的天数
@property (nonatomic, assign) NSInteger totalDays;
/// 标示第一天是星期几（0代表周日，1代表周一，以此类推）
@property (nonatomic, assign) NSInteger firstWeekday;
/// 所属年份
@property (nonatomic, assign) NSInteger year;
/// 当前月份
@property (nonatomic, assign) NSInteger month;
/// 每天所在的位置
@property (nonatomic, assign) NSInteger day;

/** 属于上个月的 */
@property (nonatomic, assign,getter=isLastMonthBool) BOOL lastMonthBool;
/** 属于下个月的 */
@property (nonatomic, assign,getter=isNextMonthBool) BOOL nextMonthBool;
/** 属于当月 */
@property (nonatomic, assign,getter=isCurrentMonthBool) BOOL currentMonthBool;
/** 今天 */
@property (nonatomic, assign,getter=isTodayBool) BOOL todayBool;
/** 是否被选中 */
@property (nonatomic, assign,getter=isSelecteBool)BOOL selectedBool;




/**
     DIY 参数
 */

/** titile字号大小  默认14*/
@property (nonatomic, assign) CGFloat titleFontFloat;
/** 当前月的title颜色 */
@property (nonatomic, strong) UIColor *currentMonthTitleColor;
/** 上月的title颜色 */
@property (nonatomic, strong) UIColor *lastMonthTitleColor;
/** 下月的title颜色 */
@property (nonatomic, strong) UIColor *nextMonthTitleColor;
/** 选中的背景颜色_级别最高 */
@property (nonatomic, strong) UIColor *selectBackColor;
/** 需要被额外标记的背景颜色_级别低于选中 */
@property (nonatomic, strong) UIColor *needToSignDateColor;
/** 选中的title颜色_级别最高 */
@property (nonatomic, strong) UIColor *selectTitleColor;
/** 需要被额外标记的title颜色_级别低于选中 */
@property (nonatomic, strong) UIColor *needToSignTitleColor;
/** 今日的title颜色_级别低于选中 */
@property (nonatomic, strong) UIColor *todayTitleColor;
/** title 的二级标记色(有些日期 除了选中 及 额外标记 也会被突出) (选中 > 标记 > 今天 > 下月 上月 > 二次标记 >当月) */
@property (nonatomic, strong) UIColor *titleSecondColor;

/** 是否显示上月，下月的的数据 */
@property (nonatomic, assign,getter=isShowLastAndNextDateBool) BOOL showLastAndNextDateBool;
/** 选中的是否动画效果 */
@property (nonatomic, assign,getter=isHaveAnimationBool) BOOL        haveAnimationBool;
/** 是否需要被额外选中 */
@property (nonatomic, assign,getter=isNeedToSignDateBool) BOOL needToSignDateBool;
/** 是否需要二次标记 */
@property (nonatomic, assign,getter=isNeedToSecondSignBool)BOOL needToSecondSignBool;

@end
