//
//  TestQuestionDAO.m
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "TestQuestionDAO.h"
#import "FMDatabase.h"
@implementation TestQuestionDAO
static TestQuestionDAO *sharedManager = nil;
+ (TestQuestionDAO*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[super alloc] init];
        
    });
    return sharedManager;
}

//查询所有数据方法
-(NSMutableArray*) findSubjectListByArticleID:(NSInteger)v_articleID{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    FMDatabase *database=[self openDB];
    NSAssert(database, @"打开数据库失败。");
    if (database) {
        FMResultSet *rs = [database executeQuery:@"SELECT * FROM testQuestions where ARTICLEID=?",@(v_articleID)];
        while ([rs next]) {
            TestQuestion* testQuestion = [[TestQuestion alloc] init];
            testQuestion.QuestionID = [rs intForColumn:@"id"];
            testQuestion.SubjectID = [rs intForColumn:@"SUBJECTID"];
            testQuestion.ArticleID = [rs intForColumn:@"ARTICLEID"];
            testQuestion.SubjectName = [rs stringForColumn:@"SUBJECTNAME"];
            testQuestion.Select1 = [rs stringForColumn:@"SELECT1"];
            testQuestion.Select2 = [rs stringForColumn:@"SELECT2"];
            testQuestion.Select3 = [rs stringForColumn:@"SELECT3"];
            testQuestion.Select4 = [rs stringForColumn:@"SELECT4"];
            testQuestion.Result = [rs stringForColumn:@"RESULT"];
            [listData addObject:testQuestion];
        }
    }
    return listData;
}
@end
