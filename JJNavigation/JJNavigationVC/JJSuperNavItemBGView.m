//
//  JJSuperNavItemBGView.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "JJSuperNavItemBGView.h"

@implementation JJSuperNavItemBGView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)createNavItemViewFromXIB
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil].firstObject;
}

-(void)setCallbackBtnClick:(BtnClickCallback)callbackBtnClick
{
    _callbackBtnClick = [callbackBtnClick copy];
}

- (void)setNavBarItemModel:(JJNavBarItemModel *)navBarItemModel
{
    _navBarItemModel = navBarItemModel;
    __weak __typeof(&*self)weakSelf = self;
    [_navBarItemModel setCallbackModelReloadAction:^{
        [weakSelf reloadNavItem];
    }];
    [self reloadNavItem];
}

- (void)updateFrame
{
    
}

- (void)reloadNavItem
{
    
}

- (void)resizeFrame:(CGRect)toFrame
{
    self.frame = toFrame;
}


@end
