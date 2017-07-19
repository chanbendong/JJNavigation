//
//  JJSuperNavItemBGView.h
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJNavBarItemModel.h"

typedef void(^BtnClickCallback)(id value);

@interface JJSuperNavItemBGView : UIView

@property (nonatomic, copy) BtnClickCallback callbackBtnClick;
@property (nonatomic, strong) JJNavBarItemModel *navBarItemModel;
@property (nonatomic, assign) CGRect adjustFrame;

- (void)updateFrame;
- (void)reloadNavItem;
+ (instancetype)createNavItemViewFromXIB;
- (void)resizeFrame:(CGRect)toFrame;

@end
