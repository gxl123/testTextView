//
//  TestQuestionBL.h
//  BusinessProcessLayer
//
//  Created by gxl on 16/11/10.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestQuestionBL : NSObject
//查询所用数据方法
-(NSMutableArray*) readData;
//通过articleID查询问题列表
-(NSMutableArray*) getSubjectsByArticleID:(int)v_articleID;
@end
