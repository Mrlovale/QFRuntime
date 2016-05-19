//
//  UIButton+Category.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/19.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "UIButton+Category.h"
#import <objc/runtime.h>

static const void *associatedKey = "associatedKey";

@implementation UIButton (Category)

//Category中的属性，只会生成setter和getter方法，不会生成成员变量
- (void)qf_addTarget:(id)target forControlEvents:(UIControlEvents)controlEvent handle:(ClickBlock)handle
{
    objc_setAssociatedObject(self, associatedKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:controlEvent];
    if (handle) {
        [self addTarget:self action:@selector(buttonClick) forControlEvents:controlEvent];
        self.click = handle;
    }
}

- (void)setClick:(ClickBlock)click
{
    objc_setAssociatedObject(self, associatedKey, click, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (ClickBlock)click
{
    return objc_getAssociatedObject(self, associatedKey);
}

- (void)buttonClick
{
    if (self.click) {
        return self.click();
    }
}

@end
