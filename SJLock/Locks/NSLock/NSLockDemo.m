//
//  NSLockDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

@property (nonatomic, strong) NSLock *lock;

@end


@implementation NSLockDemo

/*
 NSLock是对mutex普通锁的封装
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
    //  初始化锁
    self.lock = [[NSLock alloc] init];
}


/// 出票
- (void)__saleTicket {
    // 加锁
    [self.lock lock];
    
    [super __saleTicket];
    
    //  解锁
    [self.lock unlock];
}

@end
