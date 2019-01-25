//
//  PlayerViewController.m
//  CodePractice
//
//  Created by Apple on 1/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PlayerViewController.h"
static int c = 1;

@interface PlayerViewController () {
    AVAudioSession *session;
    
}

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 //   [self playAudio:nil];
    session = [AVAudioSession sharedInstance];
    
}

- (IBAction)slide:(id)sender  {
    _player.currentTime = _audioSlider.value;
}

- (void)updateTime:(NSTimer *)timer {
    _audioSlider.value = _player.currentTime;
}

-(IBAction)playAudio:(id)sender {
    
//    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//    NSString *documentsDirectory = [pathArray objectAtIndex:0];
//    NSString *soundPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%li.mp3",_songIndex]];
//
//    NSURL *soundUrl;
//    if ([[NSFileManager defaultManager] fileExistsAtPath:soundPath])
//    {
//        soundUrl = [NSURL fileURLWithPath:soundPath isDirectory:NO];
//    }

    NSLog(@"%@ sound url",_songUrlPathFromVC);
    // plau audio file
   
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:_songUrlPathFromVC error:nil];
    [_player prepareToPlay];

    _audioSlider.maximumValue = [_player duration];
    _audioSlider.value = 0.0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [_player play];
   
}

-(IBAction)stopAudio:(id)sender {
    [_player stop];
     c = 0;
}

-(IBAction)nextAudio:(id)sender {
  
    
    
    if (_player.isPlaying){
        [_player pause];
    }
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:_songUrlPathArray[_songIndex.row + c++] error:nil];
    [_player prepareToPlay];
    
    _audioSlider.maximumValue = [_player duration];
    _audioSlider.value = 0.0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [_player play];
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
