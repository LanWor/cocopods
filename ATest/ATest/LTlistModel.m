//
//  LTlistModel.m
//  ATest
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTlistModel.h"

@implementation LTlistModel

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
    self.image_url = nil;
    self.title = nil;
    [super dealloc];


}


@end
