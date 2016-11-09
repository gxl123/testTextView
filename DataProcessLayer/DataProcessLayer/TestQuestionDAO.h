//
//  TestQuestionDAO.h
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "TestQuestion.h"
#import "BaseDAO.h"
@interface TestQuestionDAO : BaseDAO
+ (TestQuestionDAO*)sharedManager;

//查询所有数据方法
-(NSMutableArray*) findAll;
@end
