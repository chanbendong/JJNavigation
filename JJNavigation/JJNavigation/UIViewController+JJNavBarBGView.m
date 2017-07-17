//
//  UIViewController+JJNavBarBGView.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "UIViewController+JJNavBarBGView.h"

static const void *kNavBarBackgroundViewKey = &kNavBarBackgroundViewKey;
static const void *kStatusBarBackgroundViewKey = &kStatusBarBackgroundViewKey;
static const void *kLeftNavItemModelArrayKey = &kLeftNavItemModelArrayKey;
static const void *kRightNavItemModelArrayKey = &kRightNavItemModelArrayKey;
static const void *kTitleNavItemModelKey = &kTitleNavItemModelKey;

@implementation UIViewController (JJNavBarBGView)

#pragma mark - 属性设置
//设置方法
-(void)setNavBarBackgroundView:(UIView *)navBarBackgroundView
{
    objc_setAssociatedObject(self, kNavBarBackgroundViewKey, navBarBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setStatusBarBackgroundView:(UIView *)statusBarBackgroundView
{
    objc_setAssociatedObject(self, kStatusBarBackgroundViewKey, statusBarBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setLeftNavItemModelArray:(NSArray<JJNavBarItemModel *> *)leftNavItemModelArray
{
    objc_setAssociatedObject(self, kLeftNavItemModelArrayKey, leftNavItemModelArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.navigationItem.leftBarButtonItems = [self buildNavItemViewWithModelArray:leftNavItemModelArray withItemType:JJNavItemTypeLeft];
    
    //    for (UIBarButtonItem *barBtnItem in self.navigationItem.leftBarButtonItems)
    //    {
    //        [self.navBarBackgroundView bringSubviewToFront:barBtnItem.customView];
    //    }
    //设置点击回调监听
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

-(void)setRightNavItemModelArray:(NSArray<JJNavBarItemModel *> *)rightNavItemModelArray
{
    objc_setAssociatedObject(self, kRightNavItemModelArrayKey, rightNavItemModelArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.navigationItem.rightBarButtonItems = [self buildNavItemViewWithModelArray:rightNavItemModelArray withItemType:JJNavItemTypeRight];
    //设置点击回调监听
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}


-(NSArray*)buildNavItemViewWithModelArray:(NSArray<JJNavBarItemModel*> *)modelArray withItemType:(JJNavItemType)itemType
{
    NSMutableArray *ListItemViewArray = [[NSMutableArray alloc]init];
    int index = 0;
    for (JJNavBarItemModel *navBarItemModel in modelArray) {
        
        navBarItemModel.tag = index;
        
    }
}


@end
