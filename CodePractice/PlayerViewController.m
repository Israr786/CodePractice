//
//  PlayerViewController.m
//  CodePractice
//
//  Created by Apple on 1/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PlayerViewController.h"
static int c = 0;

@interface PlayerViewController ()

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
    _rcc = [MPRemoteCommandCenter sharedCommandCenter];
   
    MPRemoteCommand *pauseCommand = [_rcc pauseCommand];
    [pauseCommand setEnabled:YES];
    [pauseCommand addTarget:self action:@selector(stop)];
    //
    MPRemoteCommand *playCommand = [_rcc playCommand];
    [playCommand setEnabled:YES];
    [playCommand addTarget:self action:@selector(play)];
    
    MPRemoteCommand *nextCommand = [_rcc nextTrackCommand];
    [nextCommand setEnabled:YES];
    [nextCommand addTarget:self action:@selector(next)];
    
    MPRemoteCommand *prevCommand = [_rcc previousTrackCommand];
    [prevCommand setEnabled:YES];
    [prevCommand addTarget:self action:@selector(prev)];
    
//    // Doesn’t show unless prevTrack is enabled
//    MPSkipIntervalCommand *skipBackwardCommand = [_rcc skipForwardCommand];
//    [skipBackwardCommand setEnabled:YES];
//    [skipBackwardCommand addTarget:self action:@selector(seekEvent:)];
//    skipBackwardCommand.preferredIntervals = @[@(42)];
//
//    // Doesn’t show unless nextTrack is enabled
//    MPSkipIntervalCommand *skipForwardCommand = [_rcc skipForwardCommand];
//    [skipForwardCommand setEnabled:YES];
//    [skipForwardCommand addTarget:self action:@selector(seekEvent:)];
//    skipForwardCommand.preferredIntervals = @[@(42)];
}

//-(void)skipBackwardEvent: (MPSkipIntervalCommandEvent *)skipEvent {
//    NSLog(@"Skip backward by %f", skipEvent.interval);
//}
//
//-(void)skipForwardEvent: (MPSkipIntervalCommandEvent *)skipEvent {
//    NSLog(@"Skip forward by %f", skipEvent.interval);
//}
//
//-(void) seekEvent: (MPSeekCommandEvent *) seekEvent {
//    if (seekEvent.type == MPSkipIntervalCommandEvent) {
//        NSLog(@"Begin Seeking");
//    }
//    if (seekEvent.type == MPSeekCommandEventTypeEndSeeking) {
//        NSLog(@"End Seeking");
//    }
//}

-(void)viewWillAppear:(BOOL)animated {
    [self playAudio: nil];
   
}

- (IBAction)slide:(id)sender  {
    _player.currentTime = _audioSlider.value;
}

- (void)updateTime:(NSTimer *)timer {
    _audioSlider.value = _player.currentTime;
}

- (MPRemoteCommandHandlerStatus) play
{  // if successfully played
    [self playAudio: nil];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus) stop
{  // if successfully played
    [self stopAudio: nil];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus) next
{  // if successfully played
    [self nextAudio: nil];
    return MPRemoteCommandHandlerStatusSuccess;
}

- (MPRemoteCommandHandlerStatus) prev
{  // if successfully played
    [self prevAudio: nil];
    return MPRemoteCommandHandlerStatusSuccess;
}



-(IBAction)playAudio:(id)sender {
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    NSString *soundPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3",_songIndex]];

    NSURL *soundUrl;
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundPath])
    {
        soundUrl = [NSURL fileURLWithPath:soundPath isDirectory:NO];
    }
    
    

    NSLog(@"%@ sound url",_songUrlPathFromVC);
    // plau audio file
    NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
    [songInfo setObject:_songTitle.text forKey:MPMediaItemPropertyTitle];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];


    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:_songUrlPathFromVC error:nil];
    [_player prepareToPlay];

    _audioSlider.maximumValue = [_player duration];
    _audioSlider.value = 0.0;

    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [_player play];

//
//
//    MPMusicPlayerController *controller = [MPMusicPlayerController systemMusicPlayer];
//
//    MPMediaItemCollection *collection = [[MPMediaItemCollection alloc] initWithItems:pathArray];
//    MPMediaItem *item = [collection representativeItem];
////    MPMediaItem *item = [[MPMediaItem alloc]init];
////    [item assetURL];
//
//    [controller setQueueWithItemCollection:collection];
//    [controller setNowPlayingItem:item];
//
//    [controller prepareToPlay];
//    [controller play];
//
//
//
}

-(IBAction)stopAudio:(id)sender {
    [_player stop];
     c = 0;
}

-(IBAction)nextAudio:(id)sender {
    
    if ([_songUrlPathArray count]>(_songIndex.row + c) )
    {
      
        
        _songTitle.text = _songNameList[_songIndex.row + c];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:_songUrlPathArray[_songIndex.row + c] error:nil];
        [_player prepareToPlay];
        c++;
        _audioSlider.maximumValue = [_player duration];
        _audioSlider.value = 0.0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioPlayerDidFinishPlaying:successfully:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        [songInfo setObject:_songTitle.text forKey:MPMediaItemPropertyTitle];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        
        [_player play];
        
    } else {
        if (_player.isPlaying == true){
            [_player stop];
        }
    }
    
}
-(IBAction)prevAudio:(id)sender {
    
    if ([_songUrlPathArray count]>(_songIndex.row - c) )
    {
        _songTitle.text = _songNameList[_songIndex.row + c];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:_songUrlPathArray[_songIndex.row - c] error:nil];
        [_player prepareToPlay];
        c--;
        _audioSlider.maximumValue = [_player duration];
        _audioSlider.value = 0.0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioPlayerDidFinishPlaying:successfully:) name:AVPlayerItemDidPlayToEndTimeNotification object:_player];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        [songInfo setObject:_songTitle.text forKey:MPMediaItemPropertyTitle];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
        
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
