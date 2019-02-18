//
//  YBSCalendarView.h
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/9.
//  Copyright © 2017年 温商贷. All rights reserved.
//


/**
    说明: 日历工具类

 */

#import <UIKit/UIKit.h>

typedef void (^calendarViewSelectBlock) (NSInteger year ,NSInteger month ,NSInteger day);

typedef void (^calendarViewChooseMonthBlock) (NSInteger year ,NSInteger month);

@interface YBSCalendarView : UIView

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
/** 选中的title颜色_级别最高 */
@property (nonatomic, strong) UIColor *selectTitleColor;
/** 需要被额外标记的title颜色_级别低于选中 */
@property (nonatomic, strong) UIColor *needToSignTitleColor;
/** 今日的title颜色_级别低于选中 */
@property (nonatomic, strong) UIColor *todayTitleColor;
/** 需要被额外标记的背景颜色_级别低于选中 */
@property (nonatomic, strong) UIColor *needToSignDateColor;
/** title 的二级标记色(有些日期 除了选中 及 额外标记 也会被突出) 级别< 当天 < 额外标记 < 选中 */
@property (nonatomic, strong) UIColor *titleSecondColor;
/** 选中的是否动画效果 */
@property (nonatomic, assign,getter=isHaveAnimationBool) BOOL  haveAnimationBool;
/** 是否禁止手势滚动 */
@property (nonatomic, assign,getter=isCanScrollBool) BOOL   canScrollBool;
/** 是否显示上月，下月的按钮 */
@property (nonatomic, assign,getter=isShowLastAndNextBtnBool)BOOL  showLastAndNextBtnBool;
/** 是否显示上月，下月的的数据 */
@property (nonatomic, assign,getter=isShowLastAndNextDateBool)BOOL   showLastAndNextDateBool;
/** 是否选中上次选中的 默认不选中*/
@property (nonatomic, assign,getter=isSeleLastTimeDateBool) BOOL seleLastTimeDateBool;



/** 需要被额外标记的特定日期集合  */
@property (nonatomic, strong) NSArray<NSDate *> *needToSignDateArray;
/** 需要被二级标记的特定日期集合 */
@property (nonatomic, strong) NSArray<NSDate *> *needToSecondDateArray;


/// 在配置好上面的属性之后执行 _ 必须调用
- (void)dealData;



/// 选中的回调
@property(nonatomic,copy)calendarViewSelectBlock selectBlock;
/// 因点击或左右划 导致的换月
@property(nonatomic,copy)calendarViewChooseMonthBlock chooseMonthBlock;

@end
