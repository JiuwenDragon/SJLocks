//
//  NSConditionLockDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo ()

@property (nonatomic, strong) NSConditionLock *cond;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end


@implementation NSConditionLockDemo

/*
 NSConditionLock是对NSCondition的进一步封装，可以设置具体的条件值  条件锁
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
    //  只有当条件值为1时候才能加锁，否则等待。
    //  如果不设置条件值，条件值默认是0
    //  如果直接调用 [self.cond lock];  不管条件值设置多少都会加锁成功
    self.cond = [[NSConditionLock alloc] initWithCondition:1];
}

- (void)__otherText {
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(one) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(two) object:nil] start];
}

- (void)one {
    // 加锁
    [self.cond lockWhenCondition:1];
    NSLog(@"------11111111------");
    //  解锁
    [self.cond unlockWithCondition:2];
}

- (void)two {
    // 加锁
    [self.cond lockWhenCondition:2];
    sleep(3);
    NSLog(@"------22222222------");
    //  解锁
    [self.cond unlock];
}


@end
