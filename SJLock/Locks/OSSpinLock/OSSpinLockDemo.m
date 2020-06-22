//
//  OSSpinLockDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo ()

@property (nonatomic, assign) OSSpinLock lock;

@end


@implementation OSSpinLockDemo

/*
 SSpinLock叫做”自旋锁”，等待锁的线程会处于忙等（busy-wait）状态，一直占用着CPU资源
 目前已经不再安全，可能会出现优先级反转问题
 如果等待锁的线程优先级较高，它会一直占用着CPU资源，优先级低的线程就无法释放锁
 需要导入头文件#import <libkern/OSAtomic.h>
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
    self.lock = OS_SPINLOCK_INIT;
}


/// 出票
- (void)__saleTicket {
    // 加锁
    OSSpinLockLock(&_lock);

    [super __saleTicket];
    
    //  解锁
    OSSpinLockUnlock(&_lock);

}

@end
