//
//  TestArticleDAO.m
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "TestArticleDAO.h"
#import "FMDatabase.h"

@implementation TestArticleDAO
static TestArticleDAO *sharedManager = nil;
+ (TestArticleDAO*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[super alloc] init];
        
    });
    return sharedManager;
}

//查询所有数据方法
-(NSMutableArray*) findAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    FMDatabase *database=[self openDB];
    NSAssert(database, @"打开数据库失败。");
    if (database) {
        FMResultSet *rs = [database executeQuery:@"SELECT * FROM testArticle"];
        while ([rs next]) {
            TestArticle* testArticle = [[TestArticle alloc] init];
            testArticle.ArticleID = [rs intForColumn:@"ARTICLEID"];
            testArticle.Title = [rs stringForColumn:@"TITLE"];
            testArticle.Content = [rs stringForColumn:@"CONTENT"];
            testArticle.Count = [rs intForColumn:@"COUNT_T"];
            testArticle.Author = [rs stringForColumn:@"AUTHOR"];
            [listData addObject:testArticle];
        }
    }
    return listData;
}
@end
