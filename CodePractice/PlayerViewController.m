//
//  PlayerViewController.m
//  CodePractice
//
//  Created by Apple on 1/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSArray *contents;
//    NSURL *documentsURL;
//
//
//    documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
//                                                           inDomains:NSUserDomainMask] lastObject];
//    contents = [[NSFileManager defaultManager]contentsOfDirectoryAtURL:documentsURL
//                                            includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
//
//    NSURL *songURLString = [contents objectAtIndex:0];
//
//    NSError *error;
//
//    NSData *mp3data = [NSData dataWithContentsOfURL:songURLString];
//    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:songURLString error:nil];
//    _player.numberOfLoops = -1; //infinite
//    [_player play];
//
//    NSLog(@"%@",songURLString);
    
    // get the file from directory
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    NSString *soundPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%li.mp3",_songIndex]];
    
    NSURL *soundUrl;
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundPath])
    {
        soundUrl = [NSURL fileURLWithPath:soundPath isDirectory:NO];
    }
    
    
    
    NSLog(@"%@ sound url",soundUrl);
    // plau audio file
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    [_player prepareToPlay];
    [_player play];
    [_player setVolume:5.0];
    
}

- (IBAction)slide:(id)sender  {
    _player.currentTime = _audioSlider.value;
}

- (void)updateTime:(NSTimer *)timer {
    _audioSlider.value = _player.currentTime;
}

-(IBAction)playAudio:(id)sender {
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    NSString *soundPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%li.mp3",_songIndex]];
    
    NSURL *soundUrl;
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundPath])
    {
        soundUrl = [NSURL fileURLWithPath:soundPath isDirectory:NO];
    }

    NSLog(@"%@ sound url",soundUrl);
    // plau audio file
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:soundUrl error:nil];
    [_player prepareToPlay];
//    [_player play];
    [_player setVolume:5.0];

    _audioSlider.maximumValue = [_player duration];
    _audioSlider.value = 0.0;
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    [_player play];
}

-(IBAction)stopAudio:(id)sender {
    [_player stop];
}

-(IBAction)nextAudio:(id)sender {
    [_player pause];
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
