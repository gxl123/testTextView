//
//  UICommon.h
//  GoolinkViewEasy
//
//  Created by Anni on 16/3/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define NavBarBackColor [UIColor colorWithRed:50.0f/255.0f green:54.0f/255.0f blue:61.0f/255.0f alpha:1.000]
#define SearchBtnBackColor [UIColor colorWithRed:255.0f/255.0f green:159.0f/255.0f blue:0.0f/255.0f alpha:1.000]
#define WhiteTextDICT  [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor]
@interface UICommon : NSObject
//左侧侧滑按钮
+ (void) createLeftSlideNavBarBtn:(UIViewController*)vc actionSelector:(SEL)sel;
//左侧返回按钮
+ (void) createLeftBackNavBarBtn:(UIViewController *)vc actionSelector:(SEL)sel;
//右侧新增按钮
+ (void) createRightAddNavBarBtn:(UIViewController*)vc actionSelector:(SEL)sel;
//右侧设置按钮
+ (void) createRightSetNavBarBtn:(UIViewController *)vc actionSelector:(SEL)sel;
//导航栏标题
+(void) setNavigationTitle:(UIViewController*)vc text:(NSString*)text;
@end
