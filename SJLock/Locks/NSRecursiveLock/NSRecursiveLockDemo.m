//
//  NSRecursiveLockDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "NSRecursiveLockDemo.h"

@interface NSRecursiveLockDemo ()

@property (nonatomic, strong) NSRecursiveLock *lock;

@end


@implementation NSRecursiveLockDemo

/*
 NSRecursiveLock也是对mutex递归锁的封装，API跟NSLock基本一致
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
    self.lock = [[NSRecursiveLock alloc] init];
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
