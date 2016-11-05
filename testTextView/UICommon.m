//
//  UICommon.m
//  GoolinkViewEasy
//
//  Created by Anni on 16/3/15.
//
//

#import "UICommon.h"

@implementation UICommon
//左侧侧滑按钮
+ (void) createLeftSlideNavBarBtn:(UIViewController*)vc actionSelector:(SEL)sel{
    //左侧按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"home_icon_cebianlan_selecte"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"home_icon_cebianlan_normal"] forState:UIControlStateHighlighted];
    button.frame=CGRectMake(0.0, 0.0, 38.0, 38.0);
    [button addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *moreSetButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -14;
    //vc.navigationItem.leftBarButtonItems = @[negativeSpacer, moreSetButton];
    vc.navigationItem.leftBarButtonItem=moreSetButton;
    //导航栏系统按钮颜色
    vc.navigationController.navigationBar.tintColor=SearchBtnBackColor;
}
////左侧返回按钮
//+ (void) createLeftBackNavBarBtn:(UIViewController *)vc actionSelector:(SEL)sel{
//    //左侧按钮
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"set_icon_fanhui_selecte"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"set_icon_fanhui_normal"] forState:UIControlStateHighlighted];
//    button.frame=CGRectMake(0.0, 0.0, 38.0, 38.0);
//    [button addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *moreSetButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    negativeSpacer.width = -14;
//    //self.navigationItem.leftBarButtonItems = @[negativeSpacer, moreSetButton];
//    vc.navigationItem.leftBarButtonItem=moreSetButton;
//    [moreSetButton release];
//    [negativeSpacer release];
//}
////右侧新增按钮
//+ (void) createRightAddNavBarBtn:(UIViewController*)vc actionSelector:(SEL)sel{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"home_icon_tianjia_selecte"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"home_icon_tianjia_normal"] forState:UIControlStateHighlighted];
//    button.frame=CGRectMake(0.0, 0.0, 38.0, 38.0);
//    [button addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *moreSetButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    negativeSpacer.width = -8;
//    vc.navigationItem.rightBarButtonItems = @[negativeSpacer, moreSetButton];
//    [moreSetButton release];
//    [negativeSpacer release];
//}
////右侧设置按钮
//+ (void) createRightSetNavBarBtn:(UIViewController *)vc actionSelector:(SEL)sel{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setBackgroundImage:[UIImage imageNamed:@"home_icon_set_selected_h"] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageNamed:@"home_icon_set_normal"] forState:UIControlStateHighlighted];
//    button.frame=CGRectMake(0.0, 0.0, 48.0, 48.0);
//    [button addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
//    //[button addTarget:self action:@selector(presentRightMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *moreSetButton = [[UIBarButtonItem alloc] initWithCustomView:button];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
//                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                       target:nil action:nil];
//    negativeSpacer.width = -8;
//    vc.navigationItem.rightBarButtonItems = @[negativeSpacer, moreSetButton];
//    [moreSetButton release];
//    [negativeSpacer release];
//}
//导航栏标题
+(void) setNavigationTitle:(UIViewController*)vc text:(NSString*)text{
    if(vc.navigationItem.rightBarButtonItem==nil){
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(0.0, 0.0, 38.0, 38.0);
        UIBarButtonItem *moreSetButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -8;
        vc.navigationItem.rightBarButtonItems = @[negativeSpacer, moreSetButton];

    }
    UILabel *title = [[UILabel alloc] initWithFrame:vc.view.bounds];
    title.textColor = [UIColor whiteColor];
    title.text = text;
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    title.textAlignment = NSTextAlignmentCenter;
    vc.navigationItem.titleView = title;
    //导航栏背景色
    [vc.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:50.0f/255.0f green:54.0f/255.0f blue:61.0f/255.0f alpha:1.000]];
    //导航栏系统按钮颜色
    vc.navigationController.navigationBar.tintColor=SearchBtnBackColor;
}
@end
