//
//  ViewControllerA.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/19.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "ViewControllerA.h"
#import "JJNavigationController.h"
#import "UIViewController+JJNavBarBGView.h"
@interface ViewControllerA ()

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupDefaultNavItems];
    
    self.titleNavItemModel.itemText = self.navigationController.viewControllers.count>1?[NSString stringWithFormat:@"这是第%ld个vc",self.navigationController.viewControllers.count]:@"";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(self.view.center.x-50, self.view.center.y-50, 100, 100);
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)push
{
    ViewControllerA *va = [[ViewControllerA alloc]init];
    [self.navigationController pushViewController:va animated:YES];
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
