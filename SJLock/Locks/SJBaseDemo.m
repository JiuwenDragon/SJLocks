//
//  SJBaseDemo.m
//  SJLock
//
//  Created by SJ on 2020/6/20.
//  Copyright © 2020 JiuwenDragon. All rights reserved.
//

#import "SJBaseDemo.h"

@interface SJBaseDemo ()

@property (nonatomic, assign) int ticketsCount;

@end


@implementation SJBaseDemo

/// 开始卖票
- (void)startSaleTickets {
    
    self.ticketsCount = 30;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            [self __saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i ++) {
            [self __saleTicket];
        }
    });
}

///  出票
- (void)__saleTicket {
        
    int oldTicketsCount = self.ticketsCount;
    sleep(.2);
    oldTicketsCount --;
    self.ticketsCount = oldTicketsCount;
    NSLog(@"还剩   %d   张票  -  %@",oldTicketsCount,[NSThread currentThread]);
}

- (void)__otherText {
    
}


@end
