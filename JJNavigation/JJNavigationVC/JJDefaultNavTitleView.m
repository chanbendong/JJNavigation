//
//  JJDefaultNavTitleView.m
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/19.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import "JJDefaultNavTitleView.h"

@interface JJDefaultNavTitleView()
@property (weak, nonatomic) IBOutlet UIImageView *navImage;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabelWidth;


@end


@implementation JJDefaultNavTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)reloadNavItem
{
    _navTitle.textColor = self.navBarItemModel.textColor;
    _navTitle.font = self.navBarItemModel.textFont;
    
    [self setTitle];
    [self setTitleImage];
    [self updateFrame];
}


-(void)layoutSubviews
{
    //    self.center = CGPointMake(kSCREEN_WIDTH/2.f, 44/2.f);
    
    self.frame = self.adjustFrame;
 
//    if (_navTitle.frame.size.width > self.frame.size.width)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            _navTitle.constant = self.frame.size.width;
//        });
//    }
    [self.superview sendSubviewToBack:self];
}
-(void)setTitle
{
    NSString *title = self.navBarItemModel.itemText;
    _navTitle.text = title?title:@"";
  
    
}

-(void)setTitleImage
{
    UIImage *titleImage = self.navBarItemModel.itemImg;
    
    _navImage.image = titleImage;
    
    //    [_titleImgView sizeToFit];
}

@end
