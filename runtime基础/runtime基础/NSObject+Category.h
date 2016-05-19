//
//  NSObject+Category.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/19.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NotifyBlock)(NSNotification *notify);

@interface NSObject (Category)

@property (nonatomic, copy, readonly)NotifyBlock block;
- (void)qf_addObserverForName:(NSString *)name object:(id)obj handle:(NotifyBlock)handle;

@end
