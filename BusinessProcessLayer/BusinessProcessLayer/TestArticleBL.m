//
//  TestArticleBL.m
//  BusinessProcessLayer
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "TestArticleBL.h"
#import "TestArticleDAO.h"
#import "TestArticle.h"
#import "TestQuestionDAO.h"
#import "TestQuestion.h"
@implementation TestArticleBL
//查询所用数据方法
-(NSMutableArray*) readData
{
    TestArticleDAO *dao = [TestArticleDAO sharedManager];
    
    NSMutableArray* list  = [dao findAll];
    //  NSMutableArray* list=nil;
    return list;
}

@end
