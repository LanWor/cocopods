//
//  LTDetail.h
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LTDetail : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *album_id;

- (id)initWithDic:(NSDictionary *)dic;

@end
