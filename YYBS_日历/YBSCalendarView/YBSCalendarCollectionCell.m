//
//  YBSCalendarCollectionCell.m
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/9.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import "YBSCalendarCollectionCell.h"
#import "UIView+YBSFrame.h"


#import "YBSCalendarDayItem.h"

@interface YBSCalendarCollectionCell()

@property (nonatomic, weak) UIView *bagView;
@property (nonatomic, weak) UIImageView *bagImageView;
@property (nonatomic, weak) UILabel *dayNumLable;

@end

@implementation YBSCalendarCollectionCell

- (UIView *)bagView{
    
    if (!_bagView) {
        UIView *bagView = [UIView new];
        [self.contentView addSubview:_bagView = bagView];
    }
    return _bagView;
}

- (UILabel *)dayNumLable{
    
    if (!_dayNumLable) {
        UILabel *dayNumLable = [UILabel new];
        dayNumLable.textAlignment = NSTextAlignmentCenter;
        dayNumLable.font = [UIFont systemFontOfSize:14];
        dayNumLable.backgroundColor = [UIColor whiteColor];
        [self.bagView addSubview:_dayNumLable = dayNumLable];
    }
    return _dayNumLable;
}


- (UIImageView *)bagImageView{
    
    if (!_bagImageView) {
        UIImageView *bagImageView = [UIImageView new];
        [self.bagView insertSubview:_bagImageView = bagImageView aboveSubview:self.dayNumLable];
    }
    return _bagImageView;
}


- (void)setItem:(YBSCalendarDayItem *)item{
    
    _item = item;
    
    self.bagView.backgroundColor = [UIColor whiteColor];
    self.bagImageView.backgroundColor = [UIColor whiteColor];

    self.dayNumLable.text = [NSString stringWithFormat:@"%ld",(long)item.day];
    
    
    // 字号大小
    self.dayNumLable.font = [UIFont systemFontOfSize:item.titleFontFloat];
    
    // 字体颜色 ->(选中 > 标记 > 今天 > 下月 上月 > 二次标记 >当月)
    self.dayNumLable.textColor = item.isSelecteBool? item.selectTitleColor : item.isNeedToSignDateBool? item.needToSignTitleColor : item.isLastMonthBool? item.lastMonthTitleColor : item.isNextMonthBool? item.nextMonthTitleColor : item.isTodayBool? item.todayTitleColor : item.isNeedToSecondSignBool? item.titleSecondColor : item.currentMonthTitleColor;
    
    // 字体背景颜色
    self.dayNumLable.backgroundColor = item.selectedBool? item.selectBackColor : item.isNeedToSignDateBool? item.needToSignDateColor : [UIColor whiteColor];
    
    // 小三角
    self.bagImageView.image = item.selectedBool? [UIImage imageNamed:@"taba_4_CalendarCell"] : nil;

    if (_item.isHaveAnimationBool && item.isSelecteBool) [self addAnimaiton];
}

- (void)layoutSubviews{
//    [super layoutSubviews];
    
    self.bagView.frame = self.bounds;
    
    NSInteger dayNumLable_WH = (NSInteger)self.bagView.bounds.size.width * 0.5;
    self.dayNumLable.size = CGSizeMake(dayNumLable_WH, dayNumLable_WH);
    self.dayNumLable.center = CGPointMake(self.bagView.bounds.size.width * 0.5, self.bagView.bounds.size.height * 0.5);
    self.dayNumLable.layer.cornerRadius = self.dayNumLable.bounds.size.height * 0.5;
    self.dayNumLable.layer.masksToBounds = true;
    
    self.bagImageView.size = CGSizeMake(10, 8);
    self.bagImageView.centerX = self.dayNumLable.centerX;
    self.bagImageView.bottom = self.bagView.height;
}

-(void)addAnimaiton{
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.values = @[@0.6,@1.2,@1.0];
    anim.keyPath = @"transform.scale";
    anim.calculationMode = kCAAnimationPaced;
    anim.duration = 0.3;
    anim.removedOnCompletion = YES;
    [self.bagView.layer addAnimation:anim forKey:nil];
}

@end
