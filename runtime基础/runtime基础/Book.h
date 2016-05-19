//
//  Book.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/8.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, assign)NSInteger price;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, assign)double page;
@property (nonatomic, copy)NSString *author;

@end
