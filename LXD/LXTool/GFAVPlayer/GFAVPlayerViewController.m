//
//  GFAVPlayerViewController.m
//  GFAPP
//
//  Created by XinKun on 2017/12/6.
//  Copyright © 2017年 North_feng. All rights reserved.
//

#import "GFAVPlayerViewController.h"

#import "GFAVPlayerView.h"

@interface GFAVPlayerViewController ()<GFAVPlayerViewDelegate>

/**  */
@property (nonatomic,strong) UITextView *labelDes;

/**  */
@property (nonatomic,strong) GFAVPlayerView *avPlayer;

@end

@implementation GFAVPlayerViewController


///设置导航栏样式
- (void)setNaviBarState{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
        
    
    //播放网络视频
    //http://120.25.226.186:32812/resources/videos/minion_01.mp4
    //http://ips.ifeng.com/video.ifeng.com/video04/2011/03/24/480x360_offline20110324.mp4
    
    NSString *filePath = _model.videourl;
    
    NSURL *fileURL = [NSURL URLWithString:filePath];
    if (fileURL == nil) {
        fileURL = [NSURL URLWithString:[filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    //CGRectMake(0, 100, kScreenWidth, 300)
    _avPlayer = [[GFAVPlayerView alloc] initWithFrame:CGRectMake(0, kTopNaviBarHeight, kScreenWidth, 200)];
    [_avPlayer playWith:fileURL withTitle:_model.title];
    _avPlayer.delegate = self;
    [self.view addSubview:_avPlayer];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.view addSubview:imgView];
    imgView.sd_layout.leftSpaceToView(self.view, 15).topSpaceToView(self.view, kTopNaviBarHeight + 220).widthIs(50).heightIs(50);
    kImgViewSetImage(imgView, _model.authorHeadImage, @"");
    imgView.layer.cornerRadius = 25;
    imgView.layer.masksToBounds = YES;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.text = _model.authorName;
    [self.view addSubview:label];
    label.sd_layout.leftSpaceToView(imgView, 15).centerYEqualToView(imgView).rightSpaceToView(self.view, 15).heightIs(30);
    
    
    _labelDes = [[UITextView alloc] init];
    _labelDes.text = _model.videodesc;
    _labelDes.font = [UIFont systemFontOfSize:15];
    _labelDes.textAlignment = NSTextAlignmentJustified;
    _labelDes.textColor = [UIColor lightGrayColor];
    _labelDes.editable = NO;
    [self.view addSubview:_labelDes];
    _labelDes.sd_layout.leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).topSpaceToView(imgView,15).bottomSpaceToView(self.view, 15);
    
    [self.view bringSubviewToFront:_avPlayer];
    
}


//点击返回按钮
- (void)AVPlayerClickBackButtonOnAVPlayerView:(id)sender{
    
    NSLog(@"点击了返回");
    
}

//点击全屏按钮
- (void)AVPlayerClickFullScreenButtonOnAVPlayerView:(BOOL)sender{
    NSLog(@"全屏按钮");
    if (sender) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.avPlayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.avPlayer.frame = CGRectMake(0, kTopNaviBarHeight, kScreenWidth, 200);
        }];
    }
}


//工具条显示&&隐藏
- (void)AVPlayerToolBarViewShowOrHideOnAVPlayerView:(BOOL)sender{
    
    if (sender) {
        //隐藏
        NSLog(@"工具条隐藏");
        [self setStatusBarIsHide:sender];
    }else{
        //显示
        NSLog(@"工具条显示");
        [self setStatusBarIsHide:sender];
    }
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //    static BOOL a = YES;
    //    if (a) {
    //        [self setScreenInterfaceOrientationRight];
    //        a = NO;
    //    }else{
    //        [self setScreenInterfaceOrientationDefault];
    //        a = YES;
    //    }
    
}


//开启自动旋转屏幕
- (BOOL)shouldAutorotate{
    
    return YES;
}
//设置旋转屏幕为左横和右横
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
