//
//  UIImage+category.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//  换肤可以使用 这个就可以不侵入原有的代码

#import "UIImage+category.h"
#import <objc/runtime.h>

@implementation UIImage (category)

+ (void)load
{
    Method systemClass = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method myClass = class_getClassMethod([UIImage class], @selector(qf_ImageNamed:));
    
    method_exchangeImplementations(systemClass, myClass);
}

+ (UIImage *)qf_ImageNamed:(NSString *)name
{
    BOOL themeA = NO;
    if (themeA) {
        NSLog(@"这边设置A主题的图片");
        NSString *lastPath;
        NSString *path = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:@"themeA"];
        lastPath = [path stringByAppendingPathComponent:name];
        return [UIImage imageWithContentsOfFile:lastPath];
    }
    else {
        return [UIImage qf_ImageNamed:name];
    }
    //自定义方法中最后一定要再调用一下系统的方法，让其有加载图片的功能，但是由于方法交换，系统的方法名已经变成了我们自定义的方法名（有点绕，就是用我们的名字能调用系统的方法，用系统的名字能调用我们的方法），这就实现了系统方法的拦截！
}

@end
