//
//  NSObject+JSONExtension.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/8.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONExtension)

+ (instancetype )objectWithDict:(NSDictionary *)dict;

// 返回数组中都是什么类型的模型对象
- (NSString *)arrayObjectClass;

// 返回属性和字典key的映射关系  字典Jack: 模型jack
- (NSDictionary *)propertyMapDic;

@end
