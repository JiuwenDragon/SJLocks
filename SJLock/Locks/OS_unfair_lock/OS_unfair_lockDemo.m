//
//  OS_unfair_lockDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "OS_unfair_lockDemo.h"
#import "os/lock.h"


@interface OS_unfair_lockDemo ()

@property (nonatomic, assign) os_unfair_lock lock;

@end


@implementation OS_unfair_lockDemo

/*
 os_unfair_lock用于取代不安全的OSSpinLock ，从 iOS10 开始才支持   *** iOS10 以后***
 从底层调用看，等待os_unfair_lock锁的线程会处于休眠状态，并非忙等
 需要导入头文件#import <os/lock.h>
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
    self.lock = OS_UNFAIR_LOCK_INIT;
}

/// 出票
- (void)__saleTicket {
    // 加锁
    os_unfair_lock_lock(&_lock);
    
    [super __saleTicket];
    
    //  解锁
    os_unfair_lock_unlock(&_lock);
}



@end
