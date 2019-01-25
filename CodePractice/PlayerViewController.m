//
//  PlayerViewController.m
//  CodePractice
//
//  Created by Apple on 1/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PlayerViewController.h"
static int c = 0;

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
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    _player.delegate = self;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self playAudio:nil];
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
    
    if ([_songUrlPathArray count]>(_songIndex.row + c) )
    {

        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:_songUrlPathArray[_songIndex.row + c] error:nil];
        [_player prepareToPlay];
        c++;
        _audioSlider.maximumValue = [_player duration];
        _audioSlider.value = 0.0;
    
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        [_player play];
    } else {
        if (_player.isPlaying == true){
            [_player stop];
        }
    }
    
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if (flag == true) {
        id sender = self;
        [self nextAudio:sender];
    }
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
