//
//  Pthread_rwlockDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "Pthread_rwlockDemo.h"
#import <pthread.h>

@interface Pthread_rwlockDemo ()

@property (nonatomic, assign) pthread_rwlock_t lock;

@end


@implementation Pthread_rwlockDemo

/*
 同一时间，只能有1个线程进行写的操作
 同一时间，允许有多个线程进行读的操作
 同一时间，不允许既有写的操作，又有读的操作
 
 pthread_rwlock_t  等待锁的线程会进入休眠.
 “多读单写”，经常用于文件等数据的读写操作.
*/

- (void)dealloc {
    pthread_rwlock_destroy(&_lock);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLock];
    }
    return self;
}

/// 初始化锁
- (void)initLock {
    pthread_rwlock_init(&_lock, NULL);

}

- (void)__otherText {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 10; i ++) {
        dispatch_async(queue, ^{
            [self read];
        });
        dispatch_async(queue, ^{
            [self write];
        });
    }
}

- (void)read {
    pthread_rwlock_rdlock(&_lock);
    sleep(1);
    NSLog(@"--开始读取----------------");
    pthread_rwlock_unlock(&_lock);
}

- (void)write {
    pthread_rwlock_wrlock(&_lock);
    sleep(1);
    NSLog(@"----------------开始写入--");
    pthread_rwlock_unlock(&_lock);
}

@end
