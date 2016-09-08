//
//  LTdalist.m
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTdalist.h"

@implementation LTdalist

- (id)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


- (void)dealloc {
    self.title = nil;
    self.duration = nil;
    self.play_count = nil;
    self.play_mp3_url_32 = nil;
    [super dealloc];


}


@end
