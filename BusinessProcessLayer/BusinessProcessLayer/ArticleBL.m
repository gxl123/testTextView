//
//  ArticleBL.m
//  BusinessProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "ArticleBL.h"

@implementation ArticleBL
//查询所用数据方法
-(NSMutableArray*) readData
{
    ArticleDAO *dao = [ArticleDAO sharedManager];
    
    NSMutableArray* list  = [dao findAll];
    //  NSMutableArray* list=nil;
    return list;
}

@end
