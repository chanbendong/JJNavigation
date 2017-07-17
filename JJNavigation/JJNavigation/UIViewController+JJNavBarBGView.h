//
//  UIViewController+JJNavBarBGView.h
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "JJNavBarItemModel.h"
#import "JJSuperNavItemBGView.h"

@interface UIViewController (JJNavBarBGView)

//view
@property (nonatomic, strong) UIView *navBarBackgroundView;/**<导航栏背景view*/
@property (nonatomic, strong) UIView *statusBarBackgroundView;/**<状态栏背景view*/
@property (nonatomic, copy) NSArray<JJNavBarItemModel *> *leftNavItemModelArray;
@property (nonatomic, copy) NSArray<JJNavBarItemModel *> *rightNavItemModelArray;
@property (nonatomic, strong) JJNavBarItemModel *titleNavItemModel;

#pragma mark -初始化

/**<初始化导航栏*/
- (void)setupDefaultNavItems;

/**<更新导航栏itemFrame*/
- (void)updateNavbarItemFrame;

/**<初始化点击回调设置*/
-(void)setupNavBarItemCallback;

#pragma mark -item设置

#pragma mark 导航栏item获取

/**
 获取指定位置的view

 @param tag item的tag
 @param itemType item的type（左边/右边/title）
 @return 指定位置的view
 */
- (JJSuperNavItemBGView *)getNavItemBGViewWithTag:(NSInteger)tag andItemType:(JJNavItemType)itemType;
- (JJSuperNavItemBGView *)getNavItemBGViewWithItemType:(JJNavItemType)itemType;


/**
 获取指定位置的model

 @param tag item的tag
 @param itemType item的type（左边/右边/title）
 @return 指定位置的model
 */
-(JJNavBarItemModel *)getNavBarItemModelWithTag:(NSInteger)tag andItemType:(JJNavItemType)itemType;
-(JJNavBarItemModel *)getNavBarItemModelWithItemType:(JJNavItemType)itemType;

#pragma mark 导航栏item功能设置
/**
 导航栏指定按钮是否隐藏
 
 @param shouldHide 是否隐藏
 @param tag        按钮tag
 @param itemType   按钮所属位置
 */
-(void)hideNavItem:(BOOL)shouldHide withTag:(NSInteger)tag andItemType:(JJNavItemType)itemType;
-(void)hideNavItem:(BOOL)shouldHide withItemType:(JJNavItemType)itemType;

/**
 导航栏指定按钮是否可用
 
 @param isEnable 按钮是否可用
 @param tag      按钮tag
 @param itemType 按钮所属位置
 */
-(void)enableNavItem:(BOOL)isEnable withTag:(NSInteger)tag andItemType:(JJNavItemType)itemType;
-(void)enableNavItem:(BOOL)isEnable withItemType:(JJNavItemType)itemType;

/**
 显示/隐藏导航栏
 
 @param shouldHide 是否隐藏导航栏
 @param animated   是否执行动画
 */
-(void)hideNavBar:(BOOL)shouldHide animated:(BOOL)animated;

#pragma mark - 点击事件
/**
 点击左边按钮事件
 
 @param navBarItemModel 导航栏model
 */
-(void)btnLeftAction:(JJNavBarItemModel *)navBarItemModel;

/**
 点击右边按钮事件
 
 @param navBarItemModel 导航栏model
 */
-(void)btnRightAction:(JJNavBarItemModel *)navBarItemModel;

/**
 点击导航栏标题按钮事件
 
 @param navBarItemModel 导航栏item model
 */
-(void)btnTitleAction:(JJNavBarItemModel *)navBarItemModel;


/**
 返回上级vc
 */
-(void)returnToLastVC;




@end
