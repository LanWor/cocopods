//
//  LTDetailCell.h
//  ATest
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTDetail.h"
@interface LTDetailCell : UICollectionViewCell

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIImageView *postImage;
@property (nonatomic,retain) LTDetail *detail;



@end
