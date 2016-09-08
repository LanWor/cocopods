//
//  LTDetail.m
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTDetail.h"

@implementation LTDetail


- (id)initWithDic:(NSDictionary *)dic {

    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    
}

-(void)dealloc {
    self.title = nil;
    self.image_url = nil;
    self.album_id = nil;
    [super dealloc];
}


@end
