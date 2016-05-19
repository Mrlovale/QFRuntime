//
//  Class.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "ClassRoom.h"
#import <objc/runtime.h>
#import "NSObject+Coder.h"

@interface ClassRoom ()<NSCoding>

@end

@implementation ClassRoom

- (instancetype)initWithClassName:(NSString *)className grade:(NSInteger)grade students:(NSInteger)students person:(Person *)person
{
    ClassRoom *room = [[ClassRoom alloc] init];
    room.className = className;
    room.grade = grade;
    room.students = students;
    room.person = person;
    return room;
}

- (NSArray *)ignoredNames
{
    return @[];
}

- (void)saveRoom
{
    [NSKeyedArchiver archiveRootObject:self toFile:[ClassRoom path]];
}

+ (instancetype)room
{
    ClassRoom *romm = [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
    return romm;
}

+ (NSString *)path
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"classRoom.plist"];
    return path;
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
