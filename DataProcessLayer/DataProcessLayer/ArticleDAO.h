//
//  ArticleDAO.h
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"
#import "BaseDAO.h"
@interface ArticleDAO : BaseDAO
+ (ArticleDAO*)sharedManager;

//查询所有数据方法
-(NSMutableArray*) findAll;

//按照主键查询数据方法
-(Article*) findById:(NSInteger)v_id;

@end
