//
//  Pthread_mutexDemo1.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "Pthread_mutexDemo1.h"
#import <pthread.h>

@interface Pthread_mutexDemo1 ()

@property (nonatomic, assign) pthread_mutex_t lock;
@property (nonatomic, assign) pthread_cond_t cond;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

////////////////////////   条件锁
@implementation Pthread_mutexDemo1

- (void)dealloc {
    //  销毁锁
    pthread_mutex_destroy(&_lock);
    //  销毁条件
    pthread_cond_destroy(&_cond);
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
    
    self.dataArr = [[NSMutableArray alloc] init];
    
    //  初始化属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
    //  初始化锁  NULL代表使用默认属性
    pthread_mutex_init(&_lock, &attr);
    //  销毁属性
    pthread_mutexattr_destroy(&attr);
    //  初始化条件
    pthread_cond_init(&_cond, NULL);
    
}


- (void)__otherText {
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(add) object:nil] start];
}

- (void)add {
    NSLog(@"----------开始添加数据");
    // 加锁
    pthread_mutex_lock(&_lock);
    sleep(2);
    [self.dataArr addObject:@"JiuwenDragon"];
    NSLog(@"----------添加了元素");
    
    //  发送信号；激活等待该条件的线程
    pthread_cond_signal(&_cond);
    //  激活所有等待该条件的线程
//    pthread_cond_broadcast(&_cond);
    
    //  解锁
    pthread_mutex_unlock(&_lock);
}

- (void)remove {
    NSLog(@"--开始删除数据--------");
    // 加锁
    pthread_mutex_lock(&_lock);
    
    if (self.dataArr.count == 0) {
        pthread_cond_wait(&_cond, &_lock);  //  睡眠时会把锁放开；被唤醒后会再次加锁
    }
    
    [self.dataArr removeLastObject];
    NSLog(@"--删除了元素--------");
    //  解锁
    pthread_mutex_unlock(&_lock);
}


@end
