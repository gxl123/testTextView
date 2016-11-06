//
//  DEMOMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOLeftMenuViewController.h"
#import "DEMOFirstViewController.h"
#import "DEMOSecondViewController.h"
#import "AppDelegate.h"
#import "ToolCommon.h"
#import "ReadTrainTableViewController.h"
#import "AboutTableViewController.h"
@interface DEMOLeftMenuViewController (){
    NSArray *_arrTitles;
    NSArray *_arrImages;
}

@property (strong, readwrite, nonatomic) UITableView *tableView;

@end

@implementation DEMOLeftMenuViewController{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _arrTitles = @[NSLocalizedString(@"阅读训练", @""),
                    NSLocalizedString(@"阅读测试", @""),
                    NSLocalizedString(@"视觉训练", @""),
                    NSLocalizedString(@"关于", @""),];
    _arrImages = @[@"IconProfile", @"IconProfile", @"IconProfile", @"IconProfile"];
    
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        //tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        //tableView.backgroundView = nil;
         tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing.png"]];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.bounces = NO;
        tableView;
        
    });
    //[self.tableView reloadData];
    [self.view addSubview:self.tableView];
    //[self.tableView setBackgroundColor:[UIColor redColor]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#ifdef __IPHONE_6_0

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

#endif


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //GLog(tOther,(@"didRotateFromInterfaceOrientation, to = %ld", (long)self.interfaceOrientation));
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, [[UIScreen mainScreen]bounds].size.height )];
}


- (void) toDevicesController:(id)sender{
    ReadTrainTableViewController* controller=[[ReadTrainTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    [self.sideMenuViewController setContentViewController:nav animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

-(void) toFileMgntController:(id)sender{
    ReadTrainTableViewController* controller=[[ReadTrainTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    [self.sideMenuViewController setContentViewController:nav animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}

-(void) toRemoteRecordController:(id)sender{
    ReadTrainTableViewController* controller=[[ReadTrainTableViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    [self.sideMenuViewController setContentViewController:nav animated:YES];
    [self.sideMenuViewController hideMenuViewController];

}

-(void) toAboutController:(id)sender{
    AboutTableViewController *controller = [[AboutTableViewController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    [self.sideMenuViewController setContentViewController:nav animated:YES];
    [self.sideMenuViewController hideMenuViewController];
}






#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                [self toDevicesController:nil];
                break;
            case 1:
                [self toRemoteRecordController:nil];
                break;
            case 2:
                [self toFileMgntController:nil];
                break;
            case 3:
                [self toAboutController:nil];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section==1)
    {
        //        AppDelegate* appDelegate1=(AppDelegate*)[[UIApplication sharedApplication] delegate];
        //        MainsViewController* controller=(MainsViewController*)appDelegate1.viewController;
        //        controller.curDevice=(ShangYunDevice *)[[EZDeviceManager sharedInstance] objectInDevicesAtIndex:indexPath.row];
        //       [self toDevicesController:nil];
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
//{
//    return 2;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 190 : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 ) {
        //if(userIconButton==nil){AppIcon
        UIButton*  userIconButton=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width*0.5-100)*0.5, 40, 100, 100)];
        //[userIconButton setImage:[UIImage imageNamed:@"ezeye57x.png"] forState:UIControlStateNormal];
        [userIconButton setBackgroundImage:[UIImage imageNamed:@"profile.png"] forState:UIControlStateNormal];
        //UIImageView *userIconImageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        //NSString *imgFullName = [self pathForDocumentsResource:[NSString stringWithFormat:@"%@.jpg", camera.uid]];
        //BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:imgFullName];
        //snapshotImgView.image = fileExists ? [UIImage imageWithContentsOfFile:imgFullName] : [UIImage imageNamed:@"videoClip.png"];
        //userIconImageV.image=[UIImage imageNamed:@"ezeye57x.png"];
#ifndef DEF_StealthCCTVPro_PRJ
        userIconButton.layer.masksToBounds=YES;
        userIconButton.layer.cornerRadius=100/2.0f; //设置为图片宽度的一半出来为圆形
        userIconButton.layer.borderWidth=3.0f; //边框宽度
        userIconButton.layer.borderColor=[[UIColor whiteColor] CGColor];//边框颜色
#endif
       // [userIconButton addTarget:self action:@selector(toAccountController:) forControlEvents:UIControlEventTouchUpInside];
        //[btnSwitch addTarget: self action: @selector(doSwitchView:) forControlEvents: UIControlEventTouchUpInside];
        //}
        //        UILabel *uidTextView = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width/2, 20)];
        ////        uidTextView.layer.shadowColor = [[UIColor whiteColor] CGColor];
        ////        uidTextView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        ////        uidTextView.layer.shadowOpacity = 1.0f;
        ////        uidTextView.layer.shadowRadius = 1.0f;
        //        //uidTextView.backgroundColor = [UIColor clearColor];
        //       uidTextView.userInteractionEnabled = NO;
        //       if ([[EZApplicationPreference sharedInstance] isLocol]){
        //           uidTextView.text =NSLocalizedStringFromTable(@"Notsigned", @"Localization", nil);
        //       }
        //       else{
        //           NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //           uidTextView.text =[defaults objectForKey:@"ue"];
        //       }
        //        uidTextView.font = [uidTextView.font fontWithSize:18];
        //        uidTextView.textColor=[UIColor whiteColor];
        //        uidTextView.textAlignment=NSTextAlignmentCenter;
        
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor clearColor]];
        [view addSubview:userIconButton];
        //       [view addSubview:uidTextView];
        
        
        return view;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text=[_arrTitles objectAtIndex:row];
    cell.imageView.image = [UIImage imageNamed:[_arrImages objectAtIndex:row] ];
    
    return cell;
}



@end
