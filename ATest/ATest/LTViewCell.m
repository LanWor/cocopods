//
//  LTViewCell.m
//  ATest
//
//  Created by 王泉 on 15/12/23.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTViewCell.h"
#import "UIImageView+WebCache.h"
@implementation LTViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpVCellViews];
    }
    return self;
}


- (void)setUpVCellViews {
    self.postImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 30)];
    [self.contentView addSubview:_postImage];
    [_postImage release];


    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 50, self.contentView.frame.size.width, 50)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel release];
    
    

}

- (void)setListModel:(LTlistModel *)listModel {
    if (_listModel != listModel) {
        [_listModel release];
        _listModel = [listModel retain];
    }
    self.titleLabel.text = listModel.title;
    [self.postImage sd_setImageWithURL:[NSURL URLWithString:listModel.image_url] placeholderImage:nil];
}



- (void)dealloc {
    self.postImage = nil;
    self.titleLabel = nil;
    self.listModel = nil;
//    self.secLabel = nil;
    [super dealloc];


}



@end
