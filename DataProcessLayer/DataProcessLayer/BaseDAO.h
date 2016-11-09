//
//  BaseDAO.h
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDAO : NSObject{
   
}

//数据文件全路径
@property(nonatomic, strong) NSString* dbFilePath;


//打开SQLite数据库 true 打开成功 false 打开失败
-(id)openDB;


@end
