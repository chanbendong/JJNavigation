//
//  JJNavBarItemModel.h
//  JJNavigation
//
//  Created by 吴孜健 on 2017/7/17.
//  Copyright © 2017年 吴孜健. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//导航栏item内容的格式
typedef NS_ENUM(NSUInteger, JJNavItemStyle) {
    JJNavItemStyleNone,/**<空类型*/
    JJNavItemStyleImgText,/**<图片+文字类型*/
    JJNavItemStyleText,/**<纯文字类型*/
    JJNavItemStyleImg,/**<纯图片类型*/
};

//导航栏item位置
typedef NS_ENUM(NSUInteger, JJNavItemType) {
    JJNavItemTypeNone,/**<空类型*/
    JJNavItemTypeLeft,/**<导航栏左侧按钮*/
    JJNavItemTypeRight,/**<导航栏右侧按钮*/
    JJNavItemTypeTitle,/**<导航栏title*/
};

typedef void(^ModelReloadCallback)(void);

@interface JJNavBarItemModel : NSObject

@property (nonatomic, copy) NSString *itemText;
@property (nonatomic, strong) UIImage *itemImg;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) JJNavItemStyle navItemStyle;
@property (nonatomic, assign) JJNavItemType navBarItemType;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, copy) NSString *nibName;

@property (nonatomic, copy) ModelReloadCallback callbackModelReload;

- (void)setCallbackModelReloadAction:(ModelReloadCallback)result;

/**<重新载入数据model*/
- (void)reloadViewByModel;

/**
 内部方法 导航栏内容初始化
 
 @param itemText 导航栏item文字
 @param itemImage 导航栏item图片
 @param nibName nib文件名字
 
 @return self(JJNavBarItemModel)
 */
- (instancetype)initNavBarModelWithItemText:(NSString *)itemText andItemImage:(UIImage *)itemImage withNibName:(NSString *)nibName;


/**
 外层方法，导航栏全部内容初始化

 @param text 文字内容
 @param image 图片内容
 @param nibName nib文件名字
 @return 导航栏model
 */
+ (instancetype)navItemModelWithText:(NSString *)text andImage:(UIImage *)image withNibName:(NSString *)nibName;

/**
 外层方法 导航栏文字内容初始化

 @param text 文字内容
 @param nibName nib文件名字
 @return 导航栏model
 */
+(instancetype)navItemModelOnlyWithText:(NSString*)text withNibName:(NSString*)nibName;

/**
 外层方法 导航栏图片内容初始化

 @param image 图片内容
 @param nibName nib文件名字
 @return 导航栏model
 */
+(instancetype)navItemModelOnlyWithImage:(UIImage*)image withNibName:(NSString*)nibName;

@end
