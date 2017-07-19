//
//  JJDefaultItemView.h
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/19.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "JJSuperNavItemBGView.h"

static CGFloat const kItemView_WidthMin = 33.f;

@interface JJDefaultItemView : JJSuperNavItemBGView

@property (weak, nonatomic) IBOutlet UIButton *btnClick;

@end
