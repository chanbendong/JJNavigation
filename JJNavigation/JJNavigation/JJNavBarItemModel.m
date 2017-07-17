//
//  JJNavBarItemModel.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "JJNavBarItemModel.h"

@implementation JJNavBarItemModel

- (instancetype)initNavBarModelWithItemText:(NSString *)itemText andItemImage:(UIImage *)itemImage withNibName:(NSString *)nibName
{
    if (self = [super init]) {
        _itemText = itemText;
        _itemImg = itemImage;
        _nibName = nibName;
        
        self.textColor = [UIColor blackColor];
        self.textFont = [UIFont systemFontOfSize:17];
        self.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

+ (instancetype)navItemModelWithText:(NSString *)text andImage:(UIImage *)image withNibName:(NSString *)nibName
{
    return [[self alloc]initNavBarModelWithItemText:text andItemImage:image withNibName:nibName];
}

+ (instancetype)navItemModelOnlyWithText:(NSString *)text withNibName:(NSString *)nibName
{
    return [self navItemModelWithText:text andImage:nil withNibName:nibName];
}

+ (instancetype)navItemModelOnlyWithImage:(UIImage *)image withNibName:(NSString *)nibName
{
    return [self navItemModelWithText:nil andImage:image withNibName:nibName];
}

- (void)setCallbackModelReloadAction:(ModelReloadCallback)result
{
    _callbackModelReload = result;
}

#pragma mark -数据设置

-(void)setItemText:(NSString *)itemText
{
    _itemText = itemText;
    [self reloadViewByModel];
}

- (void)setItemImg:(UIImage *)itemImg
{
    _itemImg = itemImg;
    [self reloadViewByModel];
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    [self reloadViewByModel];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self reloadViewByModel];
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _textAlignment = textAlignment;
    
    [self reloadViewByModel];
}

-(void)reloadViewByModel
{
    if (self.callbackModelReload)
    {
        self.callbackModelReload();
    }
}

- (JJNavItemStyle)navItemStyle
{
    if (_itemImg && (_itemText.length>0)) {
        _navItemStyle = JJNavItemStyleImgText;
    }
    else if (_itemImg && (_itemText.length==0))
    {
        //只有图片有值
        _navItemStyle = JJNavItemStyleImg;
    }
    else if (_itemText.length>0 && !_itemImg)
    {
        //只有文字
        _navItemStyle = JJNavItemStyleText;
    }
    else
    {
        //空
        _navItemStyle = JJNavItemStyleNone;
    }
    return _navItemStyle;
}


@end
