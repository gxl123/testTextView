//
//  TestQuestionViewController.m
//  testTextView
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "TestQuestionViewController.h"
#import "TestPageTableViewController.h"
#import "TestQuestionDAO.h"
@interface TestQuestionViewController ()

@end

@implementation TestQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize  = CGSizeMake(self.view.frame.size.width*3, self.scrollView.frame.size.height);
    self.scrollView.frame = self.view.frame;
    
    
    //TestPageTableViewController* page1ViewController = [[TestPageTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UIViewController* page1ViewController = [[UIViewController alloc]init];
    //page1ViewController.question=[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID].firstObject;

    self.page1 = page1ViewController.view;
    [self.page1 setBackgroundColor:[UIColor redColor]];
    self.page1.frame = CGRectMake(0.0f, 0.0f, 320.0f, 420.0f);
    
    //TestPageTableViewController* page2ViewController = [[TestPageTableViewController alloc]initWithStyle:UITableViewStylePlain];
    //  page2ViewController.question=[[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID]objectAtIndex:1];
    UIViewController* page2ViewController = [[UIViewController alloc]init];
    self.page2 = page2ViewController.view;
    [self.page2 setBackgroundColor:[UIColor greenColor]];
    self.page2.frame = CGRectMake(320.0f, 0.0f, 320.0f, 420.0f);
    
    //TestPageTableViewController* page3ViewController = [[TestPageTableViewController alloc]initWithStyle:UITableViewStylePlain];
    //  page3ViewController.question=[[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID]objectAtIndex:2];
    UIViewController* page3ViewController = [[UIViewController alloc]init];
    self.page3 = page3ViewController.view;
    [self.page3 setBackgroundColor:[UIColor blueColor]];
    self.page3.frame = CGRectMake(2 * 320.0f, 0.0f, 320.0f, 420.0f);
    
    self.scrollView.delegate = self;
    
    [self.scrollView addSubview:self.page1];
    [self.scrollView addSubview:self.page2];
    [self.scrollView addSubview:self.page3];
    
    //self.pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //[self.navigationController pushViewController:page1ViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
    CGPoint offset = aScrollView.contentOffset;
    self.pageControl.currentPage = offset.x / 320.0f;
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
