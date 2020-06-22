//
//  ViewController.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "ViewController.h"
#import "SJBaseDemo.h"
#import "OSSpinLockDemo.h"
#import "OS_unfair_lockDemo.h"
#import "Pthread_mutexDemo.h"
#import "Pthread_mutexDemo1.h"
#import "NSLockDemo.h"
#import "NSRecursiveLockDemo.h"
#import "NSConditionDemo.h"
#import "NSConditionLockDemo.h"
#import "SerialQueueDemo.h"
#import "SemaphoreDemo.h"
#import "SynchronizedDemo.h"
#import "Pthread_rwlockDemo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SJBaseDemo *lock = [[Pthread_rwlockDemo alloc] init];
    [lock __otherText];
}


/*
 atomic用于保证属性setter、getter的原子性操作，相当于在getter和setter内部加了线程同步的锁
 可以参考源码objc4的objc-accessors.mm
 它并不能保证使用属性的过程是线程安全的   比如：对数组或字典  添加和删除元素时
 */




@end
