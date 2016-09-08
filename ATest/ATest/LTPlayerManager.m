//
//  LTPlayerManager.m
//  ATest
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTPlayerManager.h"


static LTPlayerManager *manager  = nil;
@implementation LTPlayerManager

+ (LTPlayerManager *)sharedPlayer {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LTPlayerManager alloc]init];
    });
    return  manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc]init];
    }
    return self;

}

- (void)dealloc {

    self.player = nil;
    [super dealloc];

}




@end
