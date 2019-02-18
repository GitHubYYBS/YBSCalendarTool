//
//  UIView+YBSFrame.h
//  YYBS_日历
//
//  Created by 严兵胜 on 2019/2/18.
//  Copyright © 2019 严兵胜. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YBSFrame)

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic) CGFloat left; ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top; ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right; ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom; ///< Shortcut for frame.origin.y + frame.size.height

@end

NS_ASSUME_NONNULL_END
