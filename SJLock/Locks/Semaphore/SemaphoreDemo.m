//
//  SemaphoreDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()

@property (nonatomic, strong) dispatch_semaphore_t lock;

@end


@implementation SemaphoreDemo

/*
 semaphore叫做”信号量”
 信号量的初始值，可以用来控制线程并发访问的最大数量
 信号量的初始值为1，代表同时只允许1条线程访问资源，保证线程同步
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
    self.lock = dispatch_semaphore_create(1);
}


/// 出票
- (void)__saleTicket {
    // 加锁
    dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
    
    [super __saleTicket];
    
    //  解锁
    dispatch_semaphore_signal(self.lock);
}

@end
