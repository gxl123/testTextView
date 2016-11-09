//
//  ArticleBL.h
//  BusinessProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArticleDAO.h"
#import "Article.h"
@interface ArticleBL : NSObject
//查询所用数据方法
-(NSMutableArray*) readData;
@end
