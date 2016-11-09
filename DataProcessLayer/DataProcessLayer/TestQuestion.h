//
//  TestQuestion.h
//  DataProcessLayer
//
//  Created by gxl on 16/11/9.
//  Copyright © 2016年 gxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestQuestion : NSObject

//编号
@property(nonatomic, assign) NSUInteger QuestionID;
//对应文章ID
@property(nonatomic, assign) NSUInteger ArticleID;
//题目ID
@property(nonatomic, assign) NSUInteger SubjectID;
//题目名称
@property(nonatomic, assign) NSString* SubjectName;
//选项1
@property(nonatomic, strong) NSString* Select1;
//选项1
@property(nonatomic, strong) NSString* Select2;
//选项1
@property(nonatomic, strong) NSString* Select3;
//选项1
@property(nonatomic, strong) NSString* Select4;
//结果
@property(nonatomic, strong) NSString* Result;

@end
