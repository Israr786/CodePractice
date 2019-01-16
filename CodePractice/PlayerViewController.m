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
    NSString *soundPath = [documentsDirectory stringByAppendingPathComponent:@"1.mp3"];
    
    
    
    NSURL *soundUrl;
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundPath])
    {
        soundUrl = [NSURL fileURLWithPath:soundPath isDirectory:NO];
    }
    
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:soundPath])
    {
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath isDirectory:NO];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
