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
@interface TestQuestionViewController (){
    NSArray* _arrSubjects;
}

@end

@implementation TestQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _arrSubjects=[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID];
    
    
    int nW=self.view.bounds.size.width;
    int nH=self.view.bounds.size.height;
    
    _scrollView=[[UIScrollView alloc]init];
    self.scrollView.contentSize  = CGSizeMake(nW*_arrSubjects.count, 0);
    self.scrollView.frame = self.view.frame;
    
    
//    TestPageTableViewController* page1ViewController = [[TestPageTableViewController alloc]initWithStyle:UITableViewStylePlain];
//    //UIViewController* page1ViewController = [[UIViewController alloc]init];
//    
//    page1ViewController.question=[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID].firstObject;
//    UITableView* tv1=[[UITableView alloc]init];
//    tv1.dataSource=self;
//    tv1.delegate=self;
//    self.page1 = tv1;//page1ViewController.view;
//    //[self.page1 setBackgroundColor:[UIColor redColor]];
//    self.page1.frame = CGRectMake(0.0f, 0.0f, nW, nH);
//    
//    TestPageTableViewController* page2ViewController = [[TestPageTableViewController alloc]initWithStyle:UITableViewStylePlain];
//    page2ViewController.question=[[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID]objectAtIndex:1];
//    //UIViewController* page2ViewController = [[UIViewController alloc]init];
//    self.page2 = page2ViewController.view;
//    //[self.page2 setBackgroundColor:[UIColor greenColor]];
//    self.page2.frame = CGRectMake(nW, 0.0f, nW, nH);
//    
//    TestPageTableViewController* page3ViewController = [[TestPageTableViewController alloc]initWithStyle:UITableViewStylePlain];
//      page3ViewController.question=[[[TestQuestionDAO sharedManager] findSubjectListByArticleID:_article.ArticleID]objectAtIndex:2];
//    //UIViewController* page3ViewController = [[UIViewController alloc]init];
//    self.page3 = page3ViewController.view;
//    //[self.page3 setBackgroundColor:[UIColor blueColor]];
//    self.page3.frame = CGRectMake(2 * nW, 0.0f, nW, nH);
//    
    self.scrollView.delegate = self;
    
    [self.scrollView addSubview:self.page1];
    [self.scrollView addSubview:self.page2];
    [self.scrollView addSubview:self.page3];
    
    for (int i=0; i<_arrSubjects.count; i++) {
        UITableView* tv1=[[UITableView alloc]initWithFrame:CGRectMake(nW*i, 0.0f+66, nW, nH-66)];
        tv1.dataSource=self;
        tv1.delegate=self;
        tv1.tag=i;
        [self.scrollView addSubview:tv1];
    }
    
    [self.view addSubview:self.scrollView];
    //self.pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    //[self.navigationController pushViewController:page1ViewController animated:YES];
    
        _scrollView.showsHorizontalScrollIndicator=NO; //不显示水平滑动线
        _scrollView.showsVerticalScrollIndicator=NO;//不显示垂直滑动线

        _scrollView.pagingEnabled=YES;//scrollView不会停在页面之间，即只会显示第一页或者第二页，不会各一半显示
    
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectZero];
        //设置
        _pageControl.numberOfPages=_arrSubjects.count; //设置页数为2
        _pageControl.currentPage=0; //初始页码为 0
        _pageControl.userInteractionEnabled=NO; //pagecontroller不响应点击操作
        _pageControl.alpha=0; //设置pageController 不可见
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
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    
//    if(scrollView==_scrollView){
//        
//        CGPoint offset = scrollView.contentOffset;
//        _pageControl.currentPage = offset.x / (self.view.bounds.size.width); //计算当前的页码
//        [_scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * (_pageControl.currentPage),               _scrollView.contentOffset.y) animated:YES]; //设置scrollview的显示为当前滑动到的页面
//    }
//}
#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        TestQuestion* tq =[_arrSubjects objectAtIndex:tableView.tag];
        UITextView *tvSubjectName = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 60)];
        [tvSubjectName setBackgroundColor:[UIColor clearColor]];
        [tvSubjectName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18]];
        tvSubjectName.text=tq.SubjectName;
        [tvSubjectName setTextAlignment:NSTextAlignmentLeft];
        
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor clearColor]];
        [view addSubview:tvSubjectName];
        return view;
    }
    return nil;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    TestQuestion* que=[_arrSubjects objectAtIndex:tableView.tag];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=que.Select1;
            break;
        case 1:
            cell.textLabel.text=que.Select2;
            break;
        case 2:
            cell.textLabel.text=que.Select3;
            break;
        case 3:
            cell.textLabel.text=que.Select4;
            break;
        default:
            break;
    }
    cell.imageView.image=[que.Result isEqualToString:cell.textLabel.text]? [UIImage imageNamed:@"正确.jpg"]: [UIImage imageNamed:@"错误.jpg"];
    [cell.imageView setHidden:YES];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestQuestion* que=[_arrSubjects objectAtIndex:tableView.tag];
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    for (UITableViewCell *c in [tableView visibleCells]) {
        if ([que.Result isEqualToString:c.textLabel.text]) {
            [c.imageView setHidden:NO];
            if (![que.Result isEqualToString:cell.textLabel.text]) {
                 [cell.imageView setHidden:NO];
            }
            break;
        }
    }
    
//    
//    NSInteger index = indexPath.row;
//    NSString *str=(index==0)?NSLocalizedStringFromTable(@"Whether-to-restore-the-factory_settings", @"Localization", nil):NSLocalizedStringFromTable(@"Reboot_device", @"Localization", nil);
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"CANCEL", @"Localization", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"OK_BUTTON", @"Localization", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        
//    }];
//    [alertController addAction:okAction];
//    [alertController addAction:cancelAction];
//    [self presentViewController:alertController animated:YES completion:nil];
}

@end
