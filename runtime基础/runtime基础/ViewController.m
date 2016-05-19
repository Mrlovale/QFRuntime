//
//  ViewController.m
//  runtime基础
//
//  Created by 赵大红 on 16/5/6.
//  Copyright © 2016年 赵大红. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "UIImage+category.h"
#import "Dog.h"
#import "ClassRoom.h"
#import "NSObject+Coder.h"
#import "NSObject+JSONExtension.h"
#import "Book.h"
#import "UIButton+Category.h"
#import "NSObject+Category.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    [self test2];
    [self test3];
    [self test4];
    [self test5];
    
    [_btn2 qf_addTarget:self forControlEvents:UIControlEventTouchUpInside handle:^{
        NSLog(@"点击btn");
    }];
    
    __block int a = 0;
    [self qf_addObserverForName:@"hello" object:nil handle:^(NSNotification *notify) {
        a = 2;
        NSLog(@"-------------%d",a);
    }];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hello" object:nil];
}

// 1.交换两个方法
- (void)test1
{
    [Person run];
    [Person eat];
}

// 2.拦截系统自带的方法
- (void)test2
{
    UIImage *image = [UIImage imageNamed:@"hello"];
    [self.view addSubview:[[UIImageView alloc] initWithImage:image]];
}

// 3.给类方法添加属性
- (void)test3
{
    [Dog eatSomething:@"bounds"];
    NSLog(@"%@",[Dog something]);
}

// 4.解归档
- (void)test4
{
    Person *person = [[Person alloc] init];
    person.name = @"jack";
    ClassRoom *room = [[ClassRoom alloc] initWithClassName:@"classA" grade:3 students:30 person:person];
    [room saveRoom];
    
}

- (void)test5
{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@100 forKey:@"price"];
    [dic setValue:@"hello" forKey:@"name"];
    [dic setValue:@100 forKey:@"page"];
    [dic setValue:@"jack" forKey:@"author"];
    Book *book = [Book objectWithDict:dic];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [ClassRoom room];
}


@end
