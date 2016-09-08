//
//  dalistHeaderView.m
//  ATest
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "dalistHeaderView.h"

@implementation dalistHeaderView

- (void)dealloc {
    self.groundImage = nil;
    self.titleImage = nil;
    self.nameLabel = nil;
    self.trackLabel = nil;
    [super dealloc];

}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubViews];
    }
    return self;

}

- (void)setUpSubViews {
    
    self.groundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_groundImage];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectivew = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectivew.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_groundImage addSubview:effectivew];
    
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 120, 100)];
//    _titleImage.backgroundColor = [UIColor yellowColor];
    [effectivew addSubview:_titleImage];
    [_titleImage release];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 50, 150, 50)];
//    _nameLabel.backgroundColor = [UIColor blueColor];
    _nameLabel.textColor = [UIColor whiteColor];
    [effectivew addSubview:_nameLabel];
    [_nameLabel release];
    
    self.trackLabel = [[UILabel alloc]initWithFrame:CGRectMake(310, 150, 70, 40)];
//    _trackLabel.backgroundColor  = [UIColor greenColor];
    _trackLabel.textColor = [UIColor whiteColor];
    [effectivew addSubview:_trackLabel];
    [_trackLabel release];
    [effectivew release];
    [_groundImage release];
   
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
