//
//  TestQuestionViewController.h
//  testTextView
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 ml . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestArticle.h"
@interface TestQuestionViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) TestArticle *article;
@property (strong, nonatomic) UIView *page1;
@property (strong, nonatomic) UIView *page2;
@property (strong, nonatomic) UIView *page3;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
