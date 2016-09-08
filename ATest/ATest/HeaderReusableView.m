//
//  HeaderReusableView.m
//  ATest
//
//  Created by 王泉 on 15/12/23.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "HeaderReusableView.h"
#import "LTDetailCollectionViewController.h"
@interface HeaderReusableView ()




@end


@implementation HeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSub];
    }
    return self;
}


- (void)setUpSub {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 100, self.frame.size.height)];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.text = @"titleLabel";
    [self addSubview:_titleLabel];
    [_titleLabel release];
    
    self.more = [UIButton buttonWithType:UIButtonTypeCustom];
    _more.frame = CGRectMake(self.frame.size.width - 100, 0, 100, self.frame.size.height);

    [_more setTitle:@"更多" forState:UIControlStateNormal];
    [_more setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_more setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_more addTarget:self action:@selector(moreButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_more];
    


}

- (void)moreButton {
    if (self.modelID) {
        self.modelID(self.ID,self.title);
    }
}


- (void)headerModelidWithBlock:(modelid)block {
    self.modelID = block;

}


- (void)dealloc {
    self.titleLabel = nil;
    self.more = nil;
    self.ID = nil;
    self.title = nil;
    Block_release(self.modelID);
    [super dealloc];

}


@end
