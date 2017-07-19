//
//  UIViewController+JJNavBarBGView.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "UIViewController+JJNavBarBGView.h"
#import "JJDefaultItemView.h"
#import "JJDefaultNavTitleView.h"

static const void *kNavBarBackgroundViewKey = &kNavBarBackgroundViewKey;
static const void *kStatusBarBackgroundViewKey = &kStatusBarBackgroundViewKey;
static const void *kLeftNavItemModelArrayKey = &kLeftNavItemModelArrayKey;
static const void *kRightNavItemModelArrayKey = &kRightNavItemModelArrayKey;
static const void *kTitleNavItemModelKey = &kTitleNavItemModelKey;

@implementation UIViewController (JJNavBarBGView)

#pragma mark - 属性设置
//设置方法
- (void)setNavBarBackgroundView:(UIView *)navBarBackgroundView
{
    objc_setAssociatedObject(self, kNavBarBackgroundViewKey, navBarBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setStatusBarBackgroundView:(UIView *)statusBarBackgroundView
{
    objc_setAssociatedObject(self, kStatusBarBackgroundViewKey, statusBarBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLeftNavItemModelArray:(NSArray<JJNavBarItemModel *> *)leftNavItemModelArray
{
    objc_setAssociatedObject(self, kLeftNavItemModelArrayKey, leftNavItemModelArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.navigationItem.leftBarButtonItems = [self buildNavItemViewWithModelArray:leftNavItemModelArray withItemType:JJNavItemTypeLeft];
    
    //设置点击回调监听
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

- (void)setTitleNavItemModel:(JJNavBarItemModel *)titleNavItemModel
{
    objc_setAssociatedObject(self, kTitleNavItemModelKey, titleNavItemModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //设置item数据mode其他属性
    titleNavItemModel.navBarItemType = JJNavItemTypeTitle;
    //生成itemView
    JJSuperNavItemBGView *titleItemBGView = [self createNavItemBGViewWithNavItemModel:titleNavItemModel];
    titleItemBGView.navBarItemModel = titleNavItemModel;
    self.navigationItem.titleView = titleItemBGView;
    
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

- (void)setRightNavItemModelArray:(NSArray<JJNavBarItemModel *> *)rightNavItemModelArray
{
    objc_setAssociatedObject(self, kRightNavItemModelArrayKey, rightNavItemModelArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.navigationItem.rightBarButtonItems = [self buildNavItemViewWithModelArray:rightNavItemModelArray withItemType:JJNavItemTypeRight];
    //设置点击回调监听
    [self setupNavBarItemCallback];
    
    [self updateNavbarItemFrame];
}

- (UIView *)navBarBackgroundView
{
    if (!objc_getAssociatedObject(self, kNavBarBackgroundViewKey)) {
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, 44)];
        tempView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tempView];
        self.navBarBackgroundView = tempView;
    }
    return objc_getAssociatedObject(self, kNavBarBackgroundViewKey);
}
- (UIView *)statusBarBackgroundView
{
    if (!objc_getAssociatedObject(self, kStatusBarBackgroundViewKey))
    {
        //新建
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 20)];
        tempView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:tempView];
        self.statusBarBackgroundView = tempView;
    }
    
    return objc_getAssociatedObject(self, kStatusBarBackgroundViewKey);
}

- (NSArray<JJNavBarItemModel *> *)leftNavItemModelArray
{
    return objc_getAssociatedObject(self, kLeftNavItemModelArrayKey);
}

- (NSArray<JJNavBarItemModel *> *)rightNavItemModelArray
{
    return objc_getAssociatedObject(self, kRightNavItemModelArrayKey);
}

- (JJNavBarItemModel *)titleNavItemModel
{
    return objc_getAssociatedObject(self, kTitleNavItemModelKey);
}



- (NSArray*)buildNavItemViewWithModelArray:(NSArray<JJNavBarItemModel*> *)modelArray withItemType:(JJNavItemType)itemType
{
    NSMutableArray *ListItemViewArray = [[NSMutableArray alloc]init];
    int index = 0;
    for (JJNavBarItemModel *navBarItemModel in modelArray) {
        
        //设置item数据model其他属性
        navBarItemModel.tag = index;
        navBarItemModel.navBarItemType = itemType;
        //生成itemView
        JJSuperNavItemBGView *itemBGView = [self createNavItemBGViewWithNavItemModel:navBarItemModel];
        itemBGView.navBarItemModel = navBarItemModel;
        UIBarButtonItem *barBtnView = [[UIBarButtonItem alloc]initWithCustomView:itemBGView];
        [ListItemViewArray addObject:barBtnView];
        index++;
    }
    
    
    return ListItemViewArray;
}

- (void)setupDefaultNavItems
{
    self.navBarBackgroundView.backgroundColor = [UIColor clearColor];
    self.statusBarBackgroundView.backgroundColor = [UIColor clearColor];
    
    self.titleNavItemModel = [[JJNavBarItemModel alloc]initNavBarModelWithItemText:self.title andItemImage:nil withNibName:nil];
    self.titleNavItemModel.textFont = [UIFont systemFontOfSize:17];
    
    if (self.navigationController.viewControllers.count != 1) {
        self.leftNavItemModelArray = @[[JJNavBarItemModel navItemModelOnlyWithImage:[UIImage imageNamed:@"navbar-back-black"] withNibName:nil]];
    }
}

- (void)updateNavbarItemFrame
{
    //计算两边item总长度
    UIView *leftLastView = ((UIBarButtonItem*)self.navigationItem.leftBarButtonItems.lastObject).customView;
    CGFloat leftItemWidth = leftLastView.frame.size.width + leftLastView.frame.origin.x;
    UIView *rightFirstView = ((UIBarButtonItem*)self.navigationItem.rightBarButtonItems.lastObject).customView;
    CGFloat rightItemWidth = kSCREEN_WIDTH - rightFirstView.frame.origin.x;
    
    //对比长度
    CGFloat titleWidth = 0;
    CGFloat x = 0.f;
    if (leftItemWidth >= rightItemWidth) {
        titleWidth =  kSCREEN_WIDTH - leftItemWidth*2;
        x = leftItemWidth;
    }else{
        titleWidth = kSCREEN_WIDTH - rightItemWidth*2;
        x = rightItemWidth;
    }
    
    JJSuperNavItemBGView *titleItemBGView = [self getNavItemBGViewWithItemType:JJNavItemTypeTitle];
    titleItemBGView.adjustFrame = CGRectMake(x, titleItemBGView.frame.origin.y, titleWidth, titleItemBGView.frame.size.height);
    
}

//根据nibName生成nib对象
- (id)createNavItemBGViewWithNavItemModel:(JJNavBarItemModel *)itemModel
{
    NSString *nibName = itemModel.nibName;
    JJNavItemType itemType = itemModel.navBarItemType;
    
    if (itemType == JJNavItemTypeNone)
    {
        //没有设置类型
        return nil;
    }
    else
    {
        
        if (nibName.length == 0) {
            if (itemType == JJNavItemTypeTitle) {
                nibName = NSStringFromClass([JJDefaultNavTitleView class]);
            }else{
                nibName = NSStringFromClass([JJDefaultItemView class]);
            }
        }
        Class navItemBGViewClass = NSClassFromString(nibName);
        id navItemBGView = [navItemBGViewClass createNavItemViewFromXIB];
        return navItemBGView;
        
    }

}

- (void)setupNavBarItemCallback
{
    __typeof(&*self)weakSelf = self;
    for (UIBarButtonItem *leftBarBtnItem in self.navigationItem.leftBarButtonItems) {
        JJSuperNavItemBGView *itemView = leftBarBtnItem.customView;
        [itemView setCallbackBtnClick:^(id value){
            [weakSelf btnLeftAction:value];
        }];
    }
    for (UIBarButtonItem *rightBarBtnItem in self.navigationItem.rightBarButtonItems)
    {
        JJSuperNavItemBGView *itemBGView = rightBarBtnItem.customView;
        [itemBGView setCallbackBtnClick:^(id value) {
            //点击回调
            [weakSelf btnRightAction:value];
        }];
    }
    
    
    JJSuperNavItemBGView *itemBGView = (JJSuperNavItemBGView*)self.navigationItem.titleView;
    [itemBGView setCallbackBtnClick:^(id value){
        //点击回调
        [weakSelf btnTitleAction:value];
    }];
    
}

- (JJSuperNavItemBGView *)getNavItemBGViewWithTag:(NSInteger)tag andItemType:(JJNavItemType)itemType
{
    if (itemType == JJNavItemTypeRight || itemType == JJNavItemTypeLeft) {
        NSArray *barBtnItemsArray = itemType == JJNavItemTypeLeft?self.navigationItem.leftBarButtonItems:self.navigationItem.rightBarButtonItems;
        for (UIBarButtonItem *tempBarBtnItem in barBtnItemsArray) {
            JJSuperNavItemBGView *tempNavItemBGView = tempBarBtnItem.customView;
            if (tempNavItemBGView.navBarItemModel.tag == tag) {
                return tempNavItemBGView;
            }
        }
    }else{
        return (JJSuperNavItemBGView *)self.navigationItem.titleView;
    }
    return nil;
}

//获取第1个导航栏item
- (JJSuperNavItemBGView *)getNavItemBGViewWithItemType:(JJNavItemType)itemType
{
    return [self getNavItemBGViewWithTag:0 andItemType:itemType];
}

#pragma mark 导航栏item对应数据model获取
- (JJNavBarItemModel *)getNavBarItemModelWithTag:(NSInteger)tag andItemType:(JJNavItemType)itemType
{
    NSArray *itemModelArray = itemType == JJNavItemTypeLeft? self.leftNavItemModelArray:self.rightNavItemModelArray;
    
    for (JJNavBarItemModel *tempNavBarItemModel in itemModelArray)
    {
        if (tempNavBarItemModel.tag == tag)
        {
            return tempNavBarItemModel;
        }
    }
    
    return nil;
}

//获取第1个导航栏item数据model
- (JJNavBarItemModel *)getNavBarItemModelWithItemType:(JJNavItemType)itemType
{
    return [self getNavBarItemModelWithTag:0 andItemType:itemType];
}

#pragma mark 导航栏item功能设置
//导航栏指定按钮是否隐藏
- (void)hideNavItem:(BOOL)shouldHide withTag:(NSInteger)tag andItemType:(JJNavItemType)itemType
{
    JJSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithTag:tag andItemType:itemType];
    navItemBGView.hidden = shouldHide;
}

- (void)hideNavItem:(BOOL)shouldHide withItemType:(JJNavItemType)itemType
{
    JJSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithItemType:itemType];
    navItemBGView.hidden = shouldHide;
}

//导航栏指定按钮是否可用
- (void)enableNavItem:(BOOL)isEnable withTag:(NSInteger)tag andItemType:(JJNavItemType)itemType
{
    JJSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithTag:tag andItemType:itemType];
    navItemBGView.userInteractionEnabled = NO;
}

- (void)enableNavItem:(BOOL)isEnable withItemType:(JJNavItemType)itemType
{
    JJSuperNavItemBGView *navItemBGView = [self getNavItemBGViewWithItemType:itemType];
    navItemBGView.userInteractionEnabled = NO;
}


//显示/隐藏导航栏
- (void)hideNavBar:(BOOL)shouldHide animated:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:shouldHide animated:animated];
}

//点击左边按钮事件
- (void)btnLeftAction:(JJNavBarItemModel *)navBarItemModel
{
    //返回
    NSLog(@"左侧按钮点击");
    [self returnToLastVC];
}

//点击右边按钮事件
- (void)btnRightAction:(JJNavBarItemModel *)navBarItemModel
{
    NSLog(@"右侧按钮点击");
    
}

- (void)btnTitleAction:(JJNavBarItemModel *)navBarItemModel
{
    NSLog(@"点击title");
}

- (void)returnToLastVC
{
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}




@end
