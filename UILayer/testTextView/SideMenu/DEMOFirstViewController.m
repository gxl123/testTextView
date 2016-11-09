//
//  DEMOFirstViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOFirstViewController.h"
//#import "ToolCommon.h"
@interface DEMOFirstViewController ()

@end

@implementation DEMOFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"First Controller";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentRightMenuViewController:)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.image = [UIImage imageNamed:@"Balloon"];
    [self.view addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //GLog(tOther,(@"DEMOFirstViewController will appear"));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //GLog(tOther,(@"DEMOFirstViewController will disappear"));
}

@end
