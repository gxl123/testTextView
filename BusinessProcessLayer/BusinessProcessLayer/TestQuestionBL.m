//
//  TestQuestionBL.m
//  BusinessProcessLayer
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "TestQuestionBL.h"
#import "TestQuestionDAO.h"
#import "TestQuestion.h"
#import "TestArticleDAO.h"
#import "TestArticle.h"
@implementation TestQuestionBL{
    NSMutableArray * _allQuestions;
}

//查询所用数据方法
-(NSMutableArray*) readData
{
    TestQuestionDAO *dao = [TestQuestionDAO sharedManager];
    
    NSMutableArray* list  = [dao findAll];
    //  NSMutableArray* list=nil;
    return list;
}
//通过articleID查询问题列表
-(NSMutableArray*) getSubjectsByArticleID:(int)v_articleID
{
    if (_allQuestions) {
        _allQuestions= [self readData];
    }
    NSMutableArray *subjects = [[NSMutableArray alloc] init];
    for (TestQuestion* question in _allQuestions) {
        if(question.ArticleID==v_articleID)
            [subjects addObject:question];
        
    }
    return subjects;
}

@end
