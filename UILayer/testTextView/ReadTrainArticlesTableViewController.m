//
//  ReadTrainArticlesTableViewController.m
//  testTextView
//
//  Created by gxl on 16/11/11.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ReadTrainArticlesTableViewController.h"
#import "ArticleDAO.h"
#import "ScanReadViewController.h"
@interface ReadTrainArticlesTableViewController (){
    NSMutableArray* _arrArticle;
}

@end

@implementation ReadTrainArticlesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _arrArticle=[[NSMutableArray alloc]init];
    NSArray* arr=[[ArticleDAO sharedManager]findAll];
    for (Article* art in arr) {
        if (art.Dir_ID==_article.Dir_ID) {
            [_arrArticle addObject:art];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrArticle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    Article* ta=[_arrArticle objectAtIndex:indexPath.row];
    cell.textLabel.text=ta.Title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    ScanReadViewController* controller=[[ScanReadViewController alloc]init];
    controller.article=[_arrArticle objectAtIndex:index];
    [self.navigationController pushViewController:controller animated:YES];
}


@end
