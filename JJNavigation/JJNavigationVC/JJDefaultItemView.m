//
//  JJDefaultItemView.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/19.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "JJDefaultItemView.h"

@interface JJDefaultItemView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintImageWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelWidth;
@property (weak, nonatomic) IBOutlet UIImageView *navImage;
@property (weak, nonatomic) IBOutlet UILabel *navLaebl;


@end

@implementation JJDefaultItemView

- (void)reloadNavItem
{
    [super reloadNavItem];
    
    _navLaebl.textColor = self.navBarItemModel.textColor;
    _navLaebl.font = self.navBarItemModel.textFont;
    _navLaebl.textAlignment = self.navBarItemModel.textAlignment;
    
    [self setItemTitle];
    [self setItemImage];
    [self updatePaddingConstraint];
}

- (void)setItemTitle
{
    _navLaebl.text = self.navBarItemModel.itemText;
    
    if (self.navBarItemModel.itemText.length == 0) {
        _constraintLabelLeading.constant = 0.f;
        CGRect frame = _navLaebl.frame;
        frame.size.width = 1.f;
        _navLaebl.frame = frame;
    }
}

- (void)setItemImage
{
    
    _navImage.image = self.navBarItemModel.itemImg;
    if (self.navBarItemModel.navBarItemType == JJNavItemTypeLeft) {
        [_navImage setContentMode:UIViewContentModeRight];
    }else if (self.navBarItemModel.navBarItemType == JJNavItemTypeRight){
        [_navImage setContentMode:UIViewContentModeLeft];
    }
    CGRect itemImgViewFrame = _navImage.frame;
    itemImgViewFrame.size.width = self.navBarItemModel.itemImg.size.width;
    _navImage.frame = itemImgViewFrame;
    if (!self.navBarItemModel.itemImg) {
        _constraintImageWidth.constant = 0.f;
    }else{
        _constraintImageWidth.constant = _navImage.frame.size.width;
    }
}

- (void)updatePaddingConstraint
{
    if (!self.navBarItemModel.itemImg || (self.navBarItemModel.itemText.length == 0)) {
        _constraintLabelLeading.constant = 0.f;
    }else if (self.navBarItemModel.itemImg && (self.navBarItemModel.itemText.length == 0)){
        //只有图片
        CGFloat imgWidth = _navImage.frame.size.width+_navLaebl.frame.size.width+_constraintLabelLeading.constant;
        if (imgWidth < kItemView_WidthMin) {
            CGRect frame = _navImage.frame;
            frame.size.width = kItemView_WidthMin;
            _navImage.frame = frame;
            [self updateFrame];
            _constraintImageWidth.constant = _navImage.frame.size.width;
        }
    }else if ((self.navBarItemModel.itemText.length>0) && !self.navBarItemModel.itemImg){
        //只有文字
        if (self.frame.size.width < kItemView_WidthMin) {
            CGRect frame = _navLaebl.frame;
            frame.size.width = kItemView_WidthMin;
            _navLaebl.frame = frame;
        }
        
    }else{
        _constraintLabelLeading.constant = 5.f;
    }
    [self updateFrame];
}

- (void)updateFrame
{
    CGRect frame = self.frame;
    CGFloat originWidth = frame.size.width;
    CGFloat desWidth = _navImage.frame.size.width+_navLaebl.frame.size.width+_constraintLabelLeading.constant;
    frame.size.width = desWidth;
    if (desWidth < kItemView_WidthMin) {
        frame.size.width = kItemView_WidthMin;
    }
    if (self.navBarItemModel.navBarItemType == JJNavItemTypeRight) {
        frame.origin.x -= (frame.size.width-originWidth);
    }
    self.frame = frame;
}

- (IBAction)btnClick:(id)sender {
    if (self.callbackBtnClick) {
        __weak id weakNavItemModel = self.navBarItemModel;
        self.callbackBtnClick(weakNavItemModel);
    }
}


@end
