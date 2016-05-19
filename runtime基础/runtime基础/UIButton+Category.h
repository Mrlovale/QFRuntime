//
//  UIButton+Category.h
//  runtime基础
//
//  Created by 赵大红 on 16/5/19.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(void);

@interface UIButton (Category)

@property (nonatomic, copy, readonly)ClickBlock click;

//[btn addTarget:<#(nullable id)#> action:<#(nonnull SEL)#> forControlEvents:<#(UIControlEvents)#>]

- (void)qf_addTarget:(id)target forControlEvents:(UIControlEvents)controlEvent handle:(ClickBlock)handle;

@end
