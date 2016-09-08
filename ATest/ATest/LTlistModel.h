//
//  LTlistModel.h
//  ATest
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LTlistModel : NSObject

@property (nonatomic,copy) NSString *image_url;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *album_id;


- (id)initWithDic:(NSDictionary *)dic;

@end
