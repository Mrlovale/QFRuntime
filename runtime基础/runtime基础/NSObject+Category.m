//
//  NSObject+Category.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/19.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

static const void *associatedKey = "associatedKey";

@implementation NSObject (Category)

- (void)qf_addObserverForName:(NSString *)name object:(id)obj handle:(NotifyBlock)handle
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyAction:) name:name object:obj];
    self.block = handle;
}

- (void)setBlock:(NotifyBlock)block
{
    objc_setAssociatedObject(self, associatedKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NotifyBlock)block
{
    return objc_getAssociatedObject(self, associatedKey);
}

- (void)notifyAction:(NSNotification *)notification
{
    if (self.block) {
        self.block(notification);
    }
}

@end
