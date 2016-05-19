//
//  NSObject+Coder.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/7.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Coder)

- (NSArray *)ignoredNames;
- (void)encode:(NSCoder *)aCoder;
- (void)decode:(NSCoder *)aDeCoder;

@end
