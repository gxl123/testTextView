//
//  Article.h
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

//编号
@property(nonatomic, assign) NSUInteger ArticleID;
//类别名称
@property(nonatomic, strong) NSString* Dir;
//类别ID
@property(nonatomic, assign) NSUInteger Dir_ID;
//标题
@property(nonatomic, strong) NSString* Title;
//内容
@property(nonatomic, strong) NSString* Content;
//字数
@property(nonatomic, assign) int Count;
//作者
@property(nonatomic, strong) NSString* Author;

@end
