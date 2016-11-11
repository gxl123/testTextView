//
//  ReadTrainTableViewController.m
//  testTextView
//
//  Created by gxl on 16/11/5.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ReadTrainTableViewController.h"
#import "UICommon.h"
#import "ArticleDAO.h"
#import "ReadTrainArticlesTableViewController.h"
@interface ReadTrainTableViewController (){
    NSMutableArray * _arrayDir;
}

@end

@implementation ReadTrainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //左侧按钮
    [UICommon createLeftSlideNavBarBtn:self actionSelector:@selector(presentLeftMenuViewController:)];
    [UICommon setNavigationTitle:self text:NSLocalizedString(@"阅读训练", @"")];
    _arrayDir = [[NSMutableArray alloc]init];
    NSArray* _arr = [[ArticleDAO sharedManager] findAll];
    for (Article* art in _arr) {
        BOOL bFind=NO;
        for (Article* art2 in _arrayDir) {
            if (art2.Dir_ID==art.Dir_ID) {
                bFind=YES;
                break;
            }
        }
        if (!bFind) {
             [_arrayDir addObject:art];
        }
    }
//    ArticleBL* abl= [[ArticleBL alloc]init];
//    NSArray * arrayArticles= [abl readData];
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
    return _arrayDir.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    Article* ta=[_arrayDir objectAtIndex:indexPath.row];
    cell.textLabel.text=ta.Dir;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
     ReadTrainArticlesTableViewController* controller=[[ReadTrainArticlesTableViewController alloc]init];
    controller.article=[_arrayDir objectAtIndex:index];
    [self.navigationController pushViewController:controller animated:YES];
 }

@end
