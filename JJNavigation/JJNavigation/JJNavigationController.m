//
//  JJNavigationController.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "JJNavigationController.h"

@interface JJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置navigationbar的item
    
     self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count == 1) {
            return NO;
        }
        else{
            return YES;
        }
    }
    return YES;
}

- (void)setNavBarButtonColor:(UIColor *)navBarButtonColor
{
    //导航栏按钮的颜色
    self.navigationBar.tintColor = navBarButtonColor;
}

- (void)setNavBarTitleColor:(UIColor *)titleColor withFont:(UIFont *)font
{
    //导航栏title颜色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleColor,NSForegroundColorAttributeName,font,NSFontAttributeName,nil]];
}

- (void)setNavBarTitle:(NSString *)title withTarget:(UIViewController *)target
{
    target.navigationItem.title = title;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
