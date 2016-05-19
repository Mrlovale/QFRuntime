//
//  Dog.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "Dog.h"
#import <objc/runtime.h>

static NSString *propertyName = @"name";

@implementation Dog

+ (void)eatSomething:(NSString *)name
{
//    NSString *propertyName = @"something";
    objc_setAssociatedObject(self, &propertyName, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (NSString *)something
{
//    NSString *propertyName = @"something";
    id obj = objc_getAssociatedObject(self, &propertyName);
    return (NSString *)obj;
}

@end
