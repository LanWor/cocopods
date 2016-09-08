//
//  LTdalist.h
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LTdalist : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *play_count;//播放次数
@property (nonatomic,copy) NSString *duration;//播放时长
@property (nonatomic,copy) NSString *play_mp3_url_32;


- (id)initWithDic:(NSDictionary *)dic;

@end
