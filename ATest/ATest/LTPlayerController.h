//
//  LTPlayerController.h
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LTPlayerController : UIViewController

@property (nonatomic,copy) NSString *image;
@property (nonatomic,retain) NSArray *musicArray;
@property (nonatomic,assign) NSInteger currentNum;
@property (nonatomic,copy) NSString *titleName;

@end
