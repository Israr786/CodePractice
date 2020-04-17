//
//  PlayerViewController.h
//  CodePractice
//
//  Created by Apple on 1/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayerViewController : UIViewController<AVAudioPlayerDelegate> {
    AVAudioSession *session;
}

@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) MPMusicPlayerController *mediaPlayer;
@property (assign,nonatomic) NSIndexPath *songIndex;
@property (nonatomic,strong) IBOutlet UISlider *audioSlider;
@property (nonatomic,strong) IBOutlet UIButton *audioStopButton;
@property (nonatomic,strong) IBOutlet UIButton *audioPlayButton;
@property (nonatomic,strong) IBOutlet UIButton *audioNextButton;
@property (nonatomic,strong) IBOutlet UILabel *songTitle;
@property (nonatomic,strong) NSURL *songUrlPathFromVC;
@property (nonatomic,assign) NSArray *songUrlPathArray;
@property (nonatomic,copy) NSMutableArray *songNameList;
@property (nonatomic,strong) MPRemoteCommandCenter *rcc;




-(IBAction)playAudio:(id)sender;
-(IBAction)stopAudio:(id)sender;
-(IBAction)nextAudio:(id)sender;
-(IBAction)prevAudio:(id)sender;
-(IBAction)slide:(id)sender;


@end
