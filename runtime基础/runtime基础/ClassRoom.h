//
//  Class.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface ClassRoom : NSObject

@property (nonatomic, copy)NSString *className;
@property (nonatomic, assign)NSInteger grade;
@property (nonatomic, assign)NSInteger students;
@property (nonatomic, strong)Person *person;

- (instancetype)initWithClassName:(NSString *)className grade:(NSInteger)grade students:(NSInteger)students person:(Person *)person;

- (void)saveRoom;
+ (instancetype)room;

@end
