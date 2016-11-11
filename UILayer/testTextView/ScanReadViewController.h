//
//  ScanReadViewController.h
//  testTextView
//
//  Created by gxl on 16/11/11.
//  Copyright © 2016年 ml . All rights reserved.
//

#import "ViewController.h"
#import "Article.h"
@interface ScanReadViewController : ViewController
@property (weak, nonatomic)  Article *article;
@property (weak, nonatomic) IBOutlet UITextView *tvArticle;

@end
