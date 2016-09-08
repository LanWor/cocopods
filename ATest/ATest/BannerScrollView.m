//
//  BannerScrollView.m
//  ATest
//
//  Created by 王泉 on 15/12/23.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "BannerScrollView.h"
#import "UIImageView+WebCache.h"
#define kWith self.frame.size.width
#define kheight self.frame.size.height

@interface BannerScrollView ()<UIScrollViewDelegate>

@property (nonatomic,retain) UIScrollView *scrol;
@property (nonatomic,retain) UIPageControl *page;
@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,retain) NSMutableArray *imageArr;


@end


@implementation BannerScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
                
    }
    return self;

}

- (NSMutableArray *)imageArr {

    if (!_imageArr) {
        self.imageArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _imageArr;

}


- (void)setUpViews {
    self.scrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWith, 200)];
    
    _scrol.contentSize = CGSizeMake(kWith * 4, 200);
    _scrol.showsHorizontalScrollIndicator = NO;
    _scrol.showsVerticalScrollIndicator = NO;
    _scrol.pagingEnabled = YES;
    self.scrol.delegate = self;
    
    
    for (int i = 0 ; i < 4; i++) {
        UIImageView *imagepos = [[UIImageView alloc]initWithFrame:CGRectMake(i * kWith, 0, kWith, 200)];
        imagepos.tag = 110 + i;
        [self.scrol addSubview:imagepos];
        [imagepos release];
    }
    [self addSubview:_scrol];
    [_scrol release];
    
    
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(kWith / 2 - 40, kheight - 30, 80, 20)];
    _page.currentPageIndicatorTintColor = [UIColor whiteColor];
    _page.currentPage = 0;
    _page.pageIndicatorTintColor = [UIColor darkGrayColor];
    _page.numberOfPages = 4;
    
    [self addSubview:_page];
    [_page release];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];

}



- (void)nextImage {
    NSInteger p = self.page.currentPage;
    p++;
    if (p == self.databannerarr.count) {
        p = 0;
    }
    [self.scrol setContentOffset:CGPointMake(kWith * p, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.page.currentPage = scrollView.contentOffset.x  / scrollView.frame.size.width;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}


- (void)setDatabannerarr:(NSArray *)databannerarr {
    if (_databannerarr != databannerarr) {
        [_databannerarr release];
        _databannerarr = [databannerarr retain];
    }
    for (int i = 0 ; i < databannerarr.count; i++) {
        UIImageView *imageView = (UIImageView *)[self.scrol viewWithTag:110 + i];
        NSString *str = [NSString stringWithFormat:@"%@",databannerarr[i]];
        [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:nil];
    }
}

- (void)dealloc {
    self.databannerarr = nil;
    self.imageView = nil;
    self.imageNum = nil;
    [super dealloc];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
