//
//  NSObject+JSONExtension.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/8.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "NSObject+JSONExtension.h"
#import <objc/runtime.h>

@implementation NSObject (JSONExtension)

- (void)setDict:(NSDictionary *)dic
{
    Class c = self.class;
    while (c && c != [NSObject class]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            // 0.取出所有的属性名
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            // 1.成员变量转为属性名 需要去除前面的_
            key = [key substringFromIndex:1];
            // 2.取出字典的值
            id value = dic[key];
            
            // 3.如果模型中的属性字典中并没有，则退出
            if (value == nil) {continue;}
            
            // 4.获取成员变量的类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            NSLog(@"%@",type);
            // 5.如果属性是对象属性
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                // 5.1截取对象的类型名称(例如@"NSString"，截取为NSString)
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                
                // 5.2排除系统的对象模型即为自定义类型
                if (![type hasPrefix:@"NS"]) {
                    Class class = NSClassFromString(type);
                    value = [class objectWithDict:value];
                }
                // 5.3数组类型
                else if ([type isEqualToString:@"NSArray"]) {
                    // 5.3.1如果是数组类型，将数组中的每个模型进行字典转模型，先创建一个临时数组存放模型
                    NSArray *array = (NSArray *)value;
                    NSMutableArray *mArray = [NSMutableArray array];
                    
                    // 5.3.2获取到每一个模型的类型
                    id class ;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        
                        NSString *classStr = [self arrayObjectClass];
                        class = NSClassFromString(classStr);
                    }
                    // 5.3.3将数组中的所有模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                        [mArray addObject:[class objectWithDict:value[i]]];
                    }
                    
                    value = mArray;
 
                }
            }
            
            [self setValue:value forKeyPath:key];
            
        }
        free(ivars);
        c = [c superclass];
    }
}

- (void)setDictWithMapDic:(NSDictionary *)dic withJsonDic:(NSMutableDictionary *)valueDic
{
    // 字典Jack: 模型jack
    NSArray *keyArray = [dic allKeys];
    id jsonValue;
    for (int i = 0; i < keyArray.count; i++) {
        NSString *key = keyArray[i];
        id value = dic[key];
        jsonValue = valueDic[key];
        [valueDic setObject:jsonValue forKey:value];
        [valueDic removeObjectForKey:key];
    }
    
    [self setDict:valueDic];
}

+ (instancetype )objectWithDict:(NSDictionary *)dict {
    NSObject *obj = [[self alloc]init];
    if ([obj respondsToSelector:@selector(propertyMapDic)]) {
        [obj setDictWithMapDic:[obj propertyMapDic] withJsonDic:[NSMutableDictionary dictionaryWithDictionary:dict]];
    } else {
        [obj setDict:dict];
    }
    
    return obj;
}

@end
