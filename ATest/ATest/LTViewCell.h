//
//  LTViewCell.h
//  ATest
//
//  Created by 王泉 on 15/12/23.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTlistModel.h"

@interface LTViewCell : UICollectionViewCell

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UIImageView *postImage;
@property (nonatomic,retain) LTlistModel *listModel;


@end
