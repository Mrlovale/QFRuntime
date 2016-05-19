//
//  Person.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "NSObject+Coder.h"

@implementation Person

+(void)load
{
    // 获取类方法
    Method method1 = class_getClassMethod([Person class], @selector(run));
    Method method2 = class_getClassMethod([Person class], @selector(eat));
    method_exchangeImplementations(method1, method2);

    // 获取实例方法
    Method method3 = class_getInstanceMethod([Person class], @selector(sleep));
}

+ (void)run
{
    NSLog(@"run");
}

+ (void)eat
{
    NSLog(@"eat");
}

- (void)sleep
{
    NSLog(@"sleep");
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self encode:aCoder];
}

@end
