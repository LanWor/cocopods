//
//  LTPlayerController.m
//  ATest
//
//  Created by 王泉 on 15/12/26.
//  Copyright © 2015年 lanou. All rights reserved.
//

#import "LTPlayerController.h"
#import "LTPlayerManager.h"
#import "UIImageView+WebCache.h"
#import "LTPlayer.h"
#define Kwidht self.view.frame.size.width
#define Kheight self.view.frame.size.height

@interface LTPlayerController ()

@property (nonatomic,retain) UIButton *upButton;
@property (nonatomic,retain) UIButton *nextButton;
@property (nonatomic,retain) UIButton *beginPlayer;
@property (nonatomic,retain) UISlider *progressSlider;
@property (nonatomic,retain) UILabel *line;
@property (nonatomic,retain) UILabel *anchorName;//存放主播名字
@property (nonatomic,retain) UIImageView *anchorImage;//主播头像
@property (nonatomic,retain) UIImageView *postImage;
@property (nonatomic,retain) AVPlayerItem *playerItem;



@end

@implementation LTPlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpViews];
    [self playItemWithArray];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextMP3:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

- (void)setUpViews {

    self.postImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Kwidht, 400)];
    [_postImage sd_setImageWithURL:[NSURL URLWithString:self.image]];
    [self.view addSubview:_postImage];
    [_postImage release];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effect = [[UIVisualEffectView alloc]initWithEffect:blur];
    effect.frame = CGRectMake(0, 0, Kwidht, 400);
    [_postImage addSubview:effect];
    
    
    
    self.progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(50, 400, Kwidht - 100,10)];
    _progressSlider.value = 0.0;
    _progressSlider.minimumValue = 0.0;
    _progressSlider.maximumValue = 1.0;
    _progressSlider.minimumTrackTintColor = [UIColor orangeColor];
    _progressSlider.maximumTrackTintColor = [UIColor grayColor];
    [_progressSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_progressSlider];
    [_progressSlider release];
    
    self.upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _upButton.frame = CGRectMake(75,450 , 50, 50);
    [_upButton setTitle:@"上一首" forState:UIControlStateNormal];
    [_upButton addTarget:self action:@selector(upMP3:) forControlEvents:UIControlEventTouchUpInside];
    _upButton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_upButton];
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake(275, 450, 50, 50);
    [_nextButton setTitle:@"下一首" forState:UIControlStateNormal];
    [_nextButton addTarget:self action:@selector(nextMP3:) forControlEvents:UIControlEventTouchUpInside];
    _nextButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:_nextButton];
    self.beginPlayer = [UIButton buttonWithType:UIButtonTypeCustom];
    _beginPlayer.frame = CGRectMake(175, 450, 50, 50);
    [_beginPlayer setTitle:@"暂停" forState:UIControlStateNormal];
    [_beginPlayer addTarget:self action:@selector(playOrPaush:) forControlEvents:UIControlEventTouchUpInside];
    _beginPlayer.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_beginPlayer];

    self.line = [[UILabel alloc]initWithFrame:CGRectMake(0, 520, Kwidht, 1)];
    _line.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_line];
    [_line release];

    self.anchorImage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 540, 100, 100)];
    _anchorImage.layer.cornerRadius = 50;
    _anchorImage.layer.masksToBounds = YES;
    [_anchorImage sd_setImageWithURL:[NSURL URLWithString:self.image]];
    _anchorImage.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_anchorImage];
    [_anchorImage release];
    
    self.anchorName = [[UILabel alloc]initWithFrame:CGRectMake(200, 570, 150, 50)];
    _anchorName.text = self.titleName;
    [self.view addSubview:_anchorName];
    [_anchorName release];
    
    
    
    
}

- (void)upMP3:(UIButton *)sender {
    self.currentNum--;
    if (self.currentNum == -1) {
        self.currentNum = self.musicArray.count - 1;
    }
    [self playItemWithArray];

}

- (void)nextMP3:(UIButton *)sender {
    self.currentNum++;
    if (self.currentNum == self.musicArray.count) {
        self.currentNum = 0;
    }
    [self playItemWithArray];

}



- (void)playOrPaush:(UIButton *)sender {
    if ([LTPlayerManager sharedPlayer].player.rate == 0) {
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        [[LTPlayerManager sharedPlayer].player play];
    } else {
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        [[LTPlayerManager sharedPlayer].player pause];
    }
}



- (void)playItemWithArray {
    LTPlayer *ltplayer = self.musicArray[self.currentNum];
    self.playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:ltplayer.play_mp3_url_32]];
    [[LTPlayerManager sharedPlayer].player replaceCurrentItemWithPlayerItem:self.playerItem];
    [[LTPlayerManager sharedPlayer].player play];
    [[LTPlayerManager sharedPlayer].player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat currentTime = CMTimeGetSeconds(time);
        CGFloat totalTime = CMTimeGetSeconds(self.playerItem.duration);
        
        [self.progressSlider setValue:currentTime / totalTime];
        
    }];

}

- (void)sliderValueChange:(UISlider *)sender {
    [[LTPlayerManager sharedPlayer].player pause];
    [self.beginPlayer setTitle:@"播放" forState:UIControlStateNormal];
    CGFloat time = sender.value * CMTimeGetSeconds(self.playerItem.duration);
    switch ([self.playerItem status]) {
        case AVPlayerItemStatusReadyToPlay:
            [[LTPlayerManager sharedPlayer].player seekToTime:CMTimeMake(time, 1) completionHandler:^(BOOL finished) {
                [[LTPlayerManager sharedPlayer].player play];
                [self.beginPlayer setTitle:@"暂停" forState:UIControlStateNormal];
            }];
            break;
            
        default:
            break;
    }
    
    
    
    
    
}

- (void)dealloc {
    self.image = nil;
    self.musicArray = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [super dealloc];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
