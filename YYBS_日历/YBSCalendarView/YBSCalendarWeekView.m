//
//  YBSCalendarWeekView.m
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/9.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import "YBSCalendarWeekView.h"

@implementation YBSCalendarWeekView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setWeekTitlesArray:(NSArray *)weekTitlesArray{
    
    _weekTitlesArray = weekTitlesArray;
    
    CGFloat width = self.bounds.size.width /weekTitlesArray.count;
    for (int i = 0; i < weekTitlesArray.count; i++) {
        UILabel *weekLable = [UILabel new];
        weekLable.textColor = [UIColor blackColor];
        weekLable.backgroundColor = [UIColor whiteColor];
        weekLable.font = [UIFont systemFontOfSize:14];
        weekLable.text = weekTitlesArray[i];
        weekLable.frame = CGRectMake(i * width, 0, width, self.bounds.size.height);
        weekLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:weekLable];
    }
}

@end
