//
//  TestPageTableViewController.m
//  testTextView
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "TestPageTableViewController.h"

@interface TestPageTableViewController ()

@end

@implementation TestPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.tableView reloadData];
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
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *cellIdentifier = @"MyCell";
     UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
     }
     cell.textLabel.text=_question.SubjectName;
     return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    NSString *str=(index==0)?NSLocalizedStringFromTable(@"Whether-to-restore-the-factory_settings", @"Localization", nil):NSLocalizedStringFromTable(@"Reboot_device", @"Localization", nil);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"CANCEL", @"Localization", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){}];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedStringFromTable(@"OK_BUTTON", @"Localization", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){

    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
