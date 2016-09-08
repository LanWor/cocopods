//
//  LTPlayerManager.h
//  ATest
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface LTPlayerManager : NSObject

@property (nonatomic,retain) AVPlayer *player;

+ (LTPlayerManager *)sharedPlayer;



@end
