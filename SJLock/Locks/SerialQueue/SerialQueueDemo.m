//
//  SerialQueueDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "SerialQueueDemo.h"

@interface SerialQueueDemo ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation SerialQueueDemo

/*
 直接使用GCD的串行队列，也是可以实现线程同步的,队列先进先出
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
    
    self.queue = dispatch_queue_create("JiuwenDragon", DISPATCH_QUEUE_SERIAL);
}

/// 出票
- (void)__saleTicket {
    
    dispatch_async(self.queue, ^{
        [super __saleTicket];
    });
}


@end
