//
//  VisualTrainViewController.m
//  testTextView
//
//  Created by gxl on 16/11/11.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "VisualTrainViewController.h"
#import "UICommon.h"
@interface VisualTrainViewController ()

@end

@implementation VisualTrainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //左侧按钮
    [UICommon createLeftSlideNavBarBtn:self actionSelector:@selector(presentLeftMenuViewController:)];
    [UICommon setNavigationTitle:self text:NSLocalizedString(@"视觉训练", @"")];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"htm"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
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
