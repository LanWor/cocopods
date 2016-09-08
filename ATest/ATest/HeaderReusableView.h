//
//  HeaderReusableView.h
//  ATest
//
//  Created by 王泉 on 15/12/23.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTlistModel.h"

typedef void(^modelid) (NSString *modelID, NSString *title);
@interface HeaderReusableView : UICollectionReusableView

@property (nonatomic,retain) UIButton *more;
@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,copy) modelid modelID;
@property (nonatomic,retain) NSString *ID;
@property (nonatomic,retain) NSString *title;

- (void)headerModelidWithBlock:(modelid)block;

@end
