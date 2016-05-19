//
//  NSObject+Coder.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/7.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "NSObject+Coder.h"
#import <objc/runtime.h>

@implementation NSObject (Coder)

- (NSArray *)ignoredNames
{
    return @[];
}

// 解档
- (void)decode:(NSCoder *)aDeCoder
{
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) {continue;}
            }
            
            id value = [aDeCoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
    }
}

// 归档
- (void)encode:(NSCoder *)aCoder
{
    // 一层层父类往上查找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) {continue;}
            }
            
            id value = [self valueForKeyPath:key];
            [aCoder encodeObject:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
    }
}

// 第二种获取属性名称的方法
- (void)getPropertyName
{
    unsigned int count = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertys[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        NSLog(@"%@",name);
    }
}

@end
