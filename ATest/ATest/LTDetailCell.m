//
//  LTDetailCell.m
//  ATest
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTDetailCell.h"
#import "UIImageView+WebCache.h"

@implementation LTDetailCell

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

- (void)setDetail:(LTDetail *)detail {

    if (_detail != detail) {
        [_detail release];
        _detail = [detail retain];
    }
    self.titleLabel.text = detail.title;
    [self.postImage sd_setImageWithURL:[NSURL URLWithString:detail.image_url]];
    
}

- (void)dealloc {

    self.titleLabel = nil;
    self.postImage = nil;
    self.detail = nil;
    [super dealloc];


}



@end
