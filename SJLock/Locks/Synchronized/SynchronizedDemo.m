//
//  SynchronizedDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "SynchronizedDemo.h"

@interface SynchronizedDemo ()


@end


@implementation SynchronizedDemo

/*
 @synchronized是对mutex递归锁的封装
 源码查看：objc4中的objc-sync.mm文件
 @synchronized(obj)内部会生成obj对应的递归锁，然后进行加锁、解锁操作
 参数会存在哈希表中，通过参数找到对应的mutex递归锁。
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

}


/// 出票
- (void)__saleTicket {
    // 加锁
    @synchronized (self) {
        [super __saleTicket];
    }
    //  解锁
}

@end
