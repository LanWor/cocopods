//
//  LTdalistCell.h
//  ATest
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTdalist.h"
@interface LTdalistCell : UITableViewCell

@property (nonatomic,retain) UILabel *titleLabel;
@property (nonatomic,retain) UILabel *playLabel;
@property (nonatomic,retain) UILabel *durationLabel;
@property (nonatomic,retain) LTdalist *ltdalist;


@end
