//
//  YBSCalendarHeader.h
//  Wsloan_50
//
//  Created by 严兵胜 on 2017/12/9.
//  Copyright © 2017年 温商贷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^leftClickBlock)(void);
typedef void (^rightClickBlock)(void);


@interface YBSCalendarHeader : UIView

@property(nonatomic,copy)leftClickBlock leftClickBlock;
@property(nonatomic,copy)rightClickBlock rightClickBlock;

/// 是否显示左右两侧按钮
@property (nonatomic, assign,getter=isShowLeftAndRightBtnBoll) BOOL showLeftAndRightBtnBoll;
/// 显示的内容
@property (nonatomic, strong) NSString *dateStr;

@end
