//
//  ReadTestTableViewController.m
//  testTextView
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ReadTestTableViewController.h"
#import "TestArticleDAO.h"
#import "TestQuestionViewController.h"
#import "UICommon.h"
@interface ReadTestTableViewController (){
     NSArray * _arrayArticles;
}

@end

@implementation ReadTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //左侧按钮
    [UICommon createLeftSlideNavBarBtn:self actionSelector:@selector(presentLeftMenuViewController:)];
    [UICommon setNavigationTitle:self text:NSLocalizedString(@"阅读测试", @"")];
    _arrayArticles=[[TestArticleDAO sharedManager] findAll];
    [self.tableView reloadData];
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
    return _arrayArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    TestArticle* ta=[_arrayArticles objectAtIndex:indexPath.row];
    cell.textLabel.text=ta.Title;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    NSString *str=(index==0)?NSLocalizedStringFromTable(@"Whether-to-restore-the-factory_settings", @"Localization", nil):NSLocalizedStringFromTable(@"Reboot_device", @"Localization", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"CANCEL", @"Localization", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"OK_BUTTON", @"Localization", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        TestQuestionViewController* controller=[[TestQuestionViewController alloc]init];
        controller.article=[_arrayArticles objectAtIndex:index];
        [self.navigationController pushViewController:controller animated:YES];
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
