//
//  LTdalistCell.m
//  ATest
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTdalistCell.h"

@implementation LTdalistCell

- (void)dealloc {
    self.titleLabel = nil;
    self.playLabel = nil;
    self.durationLabel = nil;
    self.ltdalist = nil;
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpViews];
    }
    return self;
}
- (void)setUpViews {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, self.contentView.frame.size.width , 30)];
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel release];

    self.playLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 37, 180, 20)];
    _playLabel.font = [UIFont systemFontOfSize:10];
//    _playLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_playLabel];
    [_playLabel release];
    
    self.durationLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 37, 180, 20)];
    _durationLabel.font = [UIFont systemFontOfSize:10];
//    _durationLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_durationLabel];
    [_durationLabel release];

}

- (void)setLtdalist:(LTdalist *)ltdalist {
    if (_ltdalist != ltdalist) {
        [_ltdalist release];
        _ltdalist = [ltdalist retain];
    }
    self.titleLabel.text = ltdalist.title;
    self.playLabel.text = [NSString stringWithFormat:@"播放次数:  %@",ltdalist.play_count];
    self.durationLabel.text = [NSString stringWithFormat:@"播放时长:  %@",ltdalist.duration];
    
    
    

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
