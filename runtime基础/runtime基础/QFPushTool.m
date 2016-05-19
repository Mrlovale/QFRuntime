//
//  QFPushTool.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/8.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "QFPushTool.h"
#import <objc/runtime.h>

@implementation QFPushTool

//NSDictionary *userInfo = @{
//                           @"class": @"HSFeedsViewController",
//                           @"property": @{
//                                   @"ID": @"123",
//                                   @"type": @"12"
//                                   }
//                           };

+ (void)push:(NSDictionary *)dic
{
    // 1.取出class
    NSString *className = dic[@"class"];
    const char *name = [className cStringUsingEncoding:NSUTF8StringEncoding];
    
    // 2.获取类
    Class newClass = objc_getClass(name);
    // 3.如果不存在，则创建一个类
    if (!newClass) {
        Class superClass = [NSObject class];
        // 3.1先创建
        newClass = objc_allocateClassPair(superClass, name, 0);
        // 3.2再注册
        objc_registerClassPair(newClass);
    }
    // 4.创建对象
    id instance = [[newClass alloc] init];
    
    // 5.为对象赋值
    NSDictionary *propertys = dic[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
        if ([self checkPropertyExisitInstance:instance withPropertyName:key]) {
            [instance setObject:value forKey:key];
        }
    }];
    
    // 6.跳转(基于QF的架构)
    UITabBarController *root = (UITabBarController *)[[UIApplication sharedApplication].delegate window].rootViewController;
    UINavigationController *nav = root.viewControllers[root.selectedIndex];
    [nav pushViewController:instance animated:YES];
}

// 检查某一个类里面是否包含某一个属性
+ (BOOL)checkPropertyExisitInstance:(id)instance withPropertyName:(NSString *)name
{
    BOOL exist = NO;
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(instance, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *propertyName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([propertyName isEqualToString:name]) {
            exist = YES;
            break;
        }
    }
    free(ivars);
    
    return exist;
}

@end
