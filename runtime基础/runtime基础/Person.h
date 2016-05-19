//
//  Person.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy)NSString *name;
+ (void)run;
+ (void)eat;

@end
