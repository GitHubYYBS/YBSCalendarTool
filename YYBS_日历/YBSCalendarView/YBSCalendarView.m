//
//  YBSCalendarView.m
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/9.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import "YBSCalendarView.h"
#import "UIView+YBSFrame.h"



#import "YBSCalendarHeader.h"
#import "NSDate+YBSCalendar.h"
#import "YBSCalendarDayItem.h"
#import "YBSCalendarWeekView.h"
#import "YBSCalendarMonthItem.h"
#import "YBSCalendarCollectionCell.h"


@interface YBSCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, strong) NSMutableArray *monthdataA;//当月的模型集合
@property (nonatomic, strong) NSDate *currentMonthDate;//当月的日期
@property (nonatomic, strong) UICollectionView *collectionView;//日历
@property (nonatomic, strong) YBSCalendarHeader *calendarHeader; // 头部
@property (nonatomic, strong) YBSCalendarDayItem *selectDatItem; // 选中的天模型
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;//右滑手势
@property (nonatomic, strong) YBSCalendarWeekView *calendarWeekView; // 星期

/** 选中某一天 若未赋值 将默认选中今天*/
@property (nonatomic, strong) NSDate *seleDate;
@end

#pragma mark - 常量
static CGFloat const collectionCell_H = 45; // 日历cell_H
static CGFloat const calendarHeader_H = 50; // 年月View_H
static CGFloat const calendarWeekView_H = 40; // 星期View_H

static NSString *const cellIndentifierID = @"cellIndentifier";

@implementation YBSCalendarView


#pragma mark - init - 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.currentMonthDate = [NSDate date];
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
}


- (void)setup{
    
    // 头部年月
    [self addSubview:self.calendarHeader];
    [self dealwithCalendarHeader];
    
    // 星期
    [self addSubview:self.calendarWeekView];
    
    // 日历
    [self addSubview:self.collectionView];
    
    self.height = self.collectionView.bottom;
    
    
    //添加左滑右滑手势
    self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:self.leftSwipe];
    
    
    self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:self.rightSwipe];
    
    
}



#pragma mark - DataSource - 数据源

#pragma mark - UITableViewDataSource

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.monthdataA.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YBSCalendarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifierID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.item = self.monthdataA[indexPath.row];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YBSCalendarDayItem *item = self.monthdataA[indexPath.row];
    if (!item.isCurrentMonthBool || item == self.selectDatItem) return;
    
    self.selectDatItem.selectedBool = false;
    item.selectedBool = YES;
    self.selectDatItem = item;
    [collectionView reloadData];
    
    if (self.selectBlock) self.selectBlock(item.year, item.month, item.day);
}



#pragma mark - Click Action - 点击活动

// 左滑手势 ->下个月
-(void)leftSwipe:(UISwipeGestureRecognizer *)swipe{
    
    self.currentMonthDate = [self.currentMonthDate ybs_nextMonthDate];
    [self performAnimations:kCATransitionFromRight];
    [self responData];
}

// 右滑处理 ->上个月
-(void)rightSwipe:(UISwipeGestureRecognizer *)swipe{
    
    self.currentMonthDate = [self.currentMonthDate ybs_previousMonthDate];
    [self performAnimations:kCATransitionFromLeft];
    [self responData];
}

- (void)dealwithCalendarHeader{
    
    __weak typeof(self) weakSelf = self;
    // 点击向左
    self.calendarHeader.leftClickBlock = ^{
        [weakSelf rightSwipe:nil];
    };
    
    // 点击向右
    self.calendarHeader.rightClickBlock = ^{
        [weakSelf leftSwipe:nil];
    };
}


#pragma mark - Other Action
/// 动画处理
- (void)performAnimations:(NSString *)transition{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}


- (void)dealData{
    
    [self responData];
}


- (void)setNeedToSignDateArray:(NSArray<NSDate *> *)needToSignDateArray{
    
    _needToSignDateArray = needToSignDateArray;
    if (!self.monthdataA.count) return;
    [self dealwithNeedToSignDate];
    
    [self.collectionView reloadData];
}

- (void)setNeedToSecondDateArray:(NSArray<NSDate *> *)needToSecondDateArray{
    
    _needToSecondDateArray = needToSecondDateArray;
    if (!self.monthdataA.count) return;
    
    [self dealwithNeetToSecondSignDate];
    [self.collectionView reloadData];
}


/// 数据以及更新处理
-(void)responData{
    
    [self.monthdataA removeAllObjects];
    
    NSDate *previousMonthDate = [self.currentMonthDate ybs_previousMonthDate];
//    NSDate *nextMonthDate = [self.currentMonthDate  ybs_nextMonthDate];
    
    YBSCalendarMonthItem *curMonthModel = [[YBSCalendarMonthItem alloc] initWithDate:self.currentMonthDate];
    YBSCalendarMonthItem *lastMonthModel = [[YBSCalendarMonthItem alloc] initWithDate:previousMonthDate];
//    YBSCalendarMonthItem *nextMonthModel = [[YBSCalendarMonthItem alloc] initWithDate:nextMonthDate];
    
    self.calendarHeader.dateStr = [NSString stringWithFormat:@"%ld年%ld月",curMonthModel.year,curMonthModel.month];
    
    NSInteger firstWeekday = curMonthModel.firstWeekday;
    NSInteger totalDays = curMonthModel.totalDays;
    
    for (int i = 0; i < 42; i++) { // 6 * 7 == 42  你懂的
        
        YBSCalendarDayItem *dayItem =[[YBSCalendarDayItem alloc] init];
        
        //配置外面属性
        [self configDayModel:dayItem];
        
        dayItem.firstWeekday = firstWeekday;
        dayItem.totalDays = totalDays;
        dayItem.month = curMonthModel.month;
        dayItem.year = curMonthModel.year;
        
        
        //上个月的日期
        if (i < firstWeekday) {
            dayItem.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            dayItem.lastMonthBool = YES;
        }
        
        //当月的日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays)) {
            
            dayItem.day = i -firstWeekday +1;
            dayItem.currentMonthBool = YES;
            
            //标识是今天
            if ((curMonthModel.month == [[NSDate date] ybs_dateMonth]) && (curMonthModel.year == [[NSDate date] ybs_dateYear])) {
                
                if (i == [[NSDate date] ybs_dateDay] + firstWeekday - 1) {
                    dayItem.todayBool = YES;
                    dayItem.selectedBool = (self.selectDatItem && self.isSeleLastTimeDateBool)? false : true;
                    self.selectDatItem = (self.selectDatItem && self.isSeleLastTimeDateBool)? _selectDatItem : dayItem; // 默认选中今天
                }
            }
            
            // 检查选中的天 是否在 当月
            if (self.isSeleLastTimeDateBool && (curMonthModel.month == self.selectDatItem.month) && (curMonthModel.year == self.selectDatItem.year) && (dayItem.day == self.selectDatItem.day)) {
                dayItem.selectedBool = true;
                self.selectDatItem = dayItem;
            }
            
        }
        
        //下月的日期
        if (i >= (firstWeekday + curMonthModel.totalDays)) {
            
            dayItem.day = i - firstWeekday - curMonthModel.totalDays + 1;
            dayItem.nextMonthBool = YES;
            
        }
        
        [self.monthdataA addObject:dayItem];
        
    }
    
    // 处理需要被特殊标记的时间
    [self dealwithNeedToSignDate];
    
    // 处理需要被 二次标记的时间
    [self dealwithNeetToSecondSignDate];
    
    
    // 告诉外界 我换月了
    if (self.chooseMonthBlock) self.chooseMonthBlock(curMonthModel.year, curMonthModel.month);
    
    [self.collectionView reloadData];
    
}

/// 为 天 模型 配置外部属性
- (void)configDayModel:(YBSCalendarDayItem *)dayItem{
    
    //配置外面属性
    dayItem.haveAnimationBool = self.isHaveAnimationBool;
    dayItem.currentMonthTitleColor = self.currentMonthTitleColor;
    dayItem.lastMonthTitleColor = self.lastMonthTitleColor;
    dayItem.nextMonthTitleColor = self.nextMonthTitleColor;
    dayItem.selectBackColor = self.selectBackColor;
    dayItem.selectTitleColor = self.selectTitleColor;
    dayItem.todayTitleColor = self.todayTitleColor;
    dayItem.needToSignDateColor = self.needToSignDateColor;
    dayItem.needToSignTitleColor = self.needToSignTitleColor;
    dayItem.showLastAndNextDateBool = self.isShowLastAndNextDateBool;
    dayItem.titleFontFloat = (self.titleFontFloat > 0)? self.titleFontFloat : 14;
    dayItem.titleSecondColor = self.titleSecondColor;
}

/// 处理需要被特殊标记的时间
- (void)dealwithNeedToSignDate{
    for (NSDate *date in _needToSignDateArray) {
        for (YBSCalendarDayItem *item in self.monthdataA) {
            if (!item.isCurrentMonthBool) continue; // 非本月的 不标记
            if ((item.month == [date ybs_dateMonth]) && (item.year == [date ybs_dateYear]) && (item.day == [date ybs_dateDay])) {
                item.needToSignDateBool = true;
            }
        }
    }
}

/// 处理需要被 二次标记的时间
- (void)dealwithNeetToSecondSignDate{
    for (NSDate *date in _needToSecondDateArray) {
        for (YBSCalendarDayItem *item in self.monthdataA) {
            if (!item.isCurrentMonthBool) continue; // 非本月的 不标记
            if ((item.month == [date ybs_dateMonth]) && (item.year == [date ybs_dateYear]) && (item.day == [date ybs_dateDay])) {
                item.needToSecondSignBool = true;
            }
        }
    }
}


#pragma mark - 懒加载

- (YBSCalendarHeader *)calendarHeader{
    
    if (!_calendarHeader) {
        _calendarHeader = [[YBSCalendarHeader alloc] initWithFrame:CGRectMake(0, 0, self.width, calendarHeader_H)];
        _calendarHeader.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _calendarHeader.height - 1, _calendarHeader.width, 1)];
        lineView.backgroundColor = self.lastMonthTitleColor;
        [_calendarHeader addSubview:lineView];
    }
    return _calendarHeader;
}

- (YBSCalendarWeekView *)calendarWeekView{
    
    if (!_calendarWeekView) {
        _calendarWeekView = [[YBSCalendarWeekView alloc] initWithFrame:CGRectMake(0, self.calendarHeader.bottom, self.width, calendarWeekView_H)];
        _calendarWeekView.weekTitlesArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _calendarWeekView;
}

- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        //325*403
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        flow.sectionInset = UIEdgeInsetsMake(0 , 0, 0, 0);
        flow.itemSize = CGSizeMake(self.width / 7, collectionCell_H);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.calendarWeekView.bottom, self.width, 6 * collectionCell_H) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerClass:[YBSCalendarCollectionCell class] forCellWithReuseIdentifier:cellIndentifierID];
    }
    return _collectionView;
}

-(NSMutableArray *)monthdataA{
    
    if (!_monthdataA) {
        _monthdataA = [NSMutableArray array];
    }
    return _monthdataA;
}



@end
