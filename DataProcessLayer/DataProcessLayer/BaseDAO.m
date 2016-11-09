//
//  BaseDAO.m
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import "BaseDAO.h"
#import "FMDatabase.h"
@implementation BaseDAO{
     FMDatabase* _database;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        NSString * createtablePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"db1" ofType:@"sqlite"];
        self.dbFilePath = createtablePath;//[DBHelper applicationDocumentsDirectoryFile:DB_FILE_NAME];
//        //初始化数据库
//        DBHelper *dbhelper = [DBHelper new];
//        [dbhelper initDB];
        
    }
    
    return self;
}


-(id)openDB
{
    NSLog(@"DbFilePath = %@", self.dbFilePath);
    if(_database == NULL){
        _database = [[FMDatabase alloc] initWithPath:self.dbFilePath];
        if(![_database open]){
            NSLog(@"打开数据库失败");
            return nil;
        }
    }
    return _database;
}

- (void)closeDatabase
{
    if (_database != NULL) {
        [_database close];
        _database=NULL;
        NSLog(@"close sqlite db ok.");
    }
}
@end

