//
//  YBSCalendarHeader.m
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/9.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import "YBSCalendarHeader.h"
#import "UIView+YBSFrame.h"


@interface YBSCalendarHeader()

@property (nonatomic, weak) UILabel *timeLable;
@end

@implementation YBSCalendarHeader

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUp];
    }
    return self;
}


- (void)setUp{
    
    // 年 月
    UILabel *timeLable = [UILabel new];
    timeLable.text = @"最美的年华遇见你";
    timeLable.font = [UIFont systemFontOfSize:15];
    timeLable.textAlignment = NSTextAlignmentCenter;
    timeLable.height = self.height;
    timeLable.width = 150;
    timeLable.centerX = self.width * 0.5;
    timeLable.centerY = self.height * 0.5;
    [self addSubview:_timeLable = timeLable];
    
    // 左按钮
    UIButton *lefBtn = [[UIButton alloc] init];
    [lefBtn setImage:[UIImage imageNamed:@"taba_4_CalendarLeft"] forState:UIControlStateNormal];
    lefBtn.size = CGSizeMake(30, self.bounds.size.height);
    lefBtn.right = timeLable.left;
    [self addSubview:lefBtn];
    [lefBtn addTarget:self action:@selector(clickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    
    // 右按钮
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[UIImage imageNamed:@"taba_4_CalendarRight"] forState:UIControlStateNormal];
    rightBtn.size = CGSizeMake(30, self.bounds.size.height);
    rightBtn.left = timeLable.right;
    [self addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - Click Action - 点击活动

- (void)clickLeftBtn{
    
    if (self.leftClickBlock) self.leftClickBlock();
}


- (void)clickRightBtn{

    if (self.rightClickBlock) self.rightClickBlock();
}


#pragma mark - Other Action

- (void)setDateStr:(NSString *)dateStr{
    
    _dateStr = dateStr;
    self.timeLable.text = dateStr;
}



@end
