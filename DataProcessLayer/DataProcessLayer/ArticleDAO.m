//
//  ArticleDAO.m
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "ArticleDAO.h"
#import "FMDatabase.h"
@implementation ArticleDAO
FMDatabase *database;
static ArticleDAO *sharedManager = nil;

+ (ArticleDAO*)sharedManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[super alloc] init];
        
    });
    return sharedManager;
}

//查询所有数据方法
-(NSMutableArray*) findAll{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    database=[self openDB];
    NSAssert(database, @"打开数据库失败。");
    if (database) {
        FMResultSet *rs = [database executeQuery:@"SELECT * FROM article"];
        while ([rs next]) {
            Article* article = [[Article alloc] init];
            article.ArticleID = [rs intForColumn:@"Id"];
            article.Dir_ID = [rs intForColumn:@"DIR_ID"];
            article.Dir = [rs stringForColumn:@"DIR"];
            article.Title = [rs stringForColumn:@"TITLE"];
            article.Content = [rs stringForColumn:@"CONTENT"];
            article.Count = [rs intForColumn:@"COUNT_T"];
            article.Author = [rs stringForColumn:@"AUTHOR"];
            [listData addObject:article];
        }
    }
    return listData;
}

//按照主键查询数据方法
-(Article*) findById:(NSInteger)v_id{
    Article* article = [[Article alloc] init];
    
    return article;
}


@end
