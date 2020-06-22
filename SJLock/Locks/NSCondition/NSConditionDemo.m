//
//  NSConditionDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo ()

@property (nonatomic, strong) NSCondition *cond;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end


@implementation NSConditionDemo

/*
 NSCondition是对mutex和cond的封装   条件锁
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLock];
    }
    return self;
}

/// 初始化锁
- (void)initLock {
    
    self.dataArr = [[NSMutableArray alloc] init];

    //  初始化锁
    self.cond = [[NSCondition alloc] init];
}

- (void)__otherText {
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(add) object:nil] start];
}

- (void)add {
    NSLog(@"----------开始添加数据");
    // 加锁
    [self.cond lock];
    sleep(2);
    [self.dataArr addObject:@"JiuwenDragon"];
    NSLog(@"----------添加了元素");
    
    //  发送信号；激活等待该条件的线程
    [self.cond signal];
    //  激活所有等待该条件的线程
//    [self.cond broadcast];
    
    //  解锁
    [self.cond unlock];
}

- (void)remove {
    NSLog(@"--开始删除数据--------");
    // 加锁
    [self.cond lock];

    if (self.dataArr.count == 0) {
        [self.cond wait];
    }
    
    [self.dataArr removeLastObject];
    NSLog(@"--删除了元素--------");
    //  解锁
    [self.cond unlock];
}

@end
