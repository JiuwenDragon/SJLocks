//
//  Pthread_mutexDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "Pthread_mutexDemo.h"
#import <pthread.h>

@interface Pthread_mutexDemo ()

@property (nonatomic, assign) pthread_mutex_t lock;

@end

////////////////////////    普通锁  &&&&&&&&  递归锁
@implementation Pthread_mutexDemo

- (void)dealloc {
    //  销毁锁
    pthread_mutex_destroy(&_lock);
}

/*
 * Mutex type attributes
 
 #define PTHREAD_MUTEX_NORMAL        0 普通锁 （如果同一个线程对一把锁重复加锁会产生死锁）
 #define PTHREAD_MUTEX_ERRORCHECK    1
 #define PTHREAD_MUTEX_RECURSIVE     3 递归锁 （允许同一个线程对一把锁进行重复加锁）
 #define PTHREAD_MUTEX_DEFAULT       PTHREAD_MUTEX_NORMAL
 */

/*
 mutex叫做”互斥锁”，等待锁的线程会处于休眠状态
 需要导入头文件#import <pthread.h>
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
    
    //  初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    //  初始化锁  NULL代表使用默认属性
    pthread_mutex_init(&_lock, &attr);
    //  销毁属性
    pthread_mutexattr_destroy(&attr);
    
    
    /***************************************************************************************************
     
     初始化锁  后面也可以传 NULL  NULL默认是 PTHREAD_MUTEX_DEFAULT 类型
     pthread_mutex_init(&_lock, NULL);
     
     **************************************************************************************************/
}

/// 出票
- (void)__saleTicket {
    // 加锁
    pthread_mutex_lock(&_lock);
    
    [super __saleTicket];
    
    //  解锁
    pthread_mutex_unlock(&_lock);
}


@end
