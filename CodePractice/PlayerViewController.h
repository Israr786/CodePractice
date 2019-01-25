//
//  PlayerViewController.h
//  CodePractice
//
//  Created by Apple on 1/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : UIViewController

@property (strong, nonatomic) AVAudioPlayer *player;
@property (assign,nonatomic) NSIndexPath *songIndex;
@property (nonatomic,strong) IBOutlet UISlider *audioSlider;
@property (nonatomic,strong) IBOutlet UIButton *audioStopButton;
@property (nonatomic,strong) IBOutlet UIButton *audioPlayButton;
@property (nonatomic,strong) IBOutlet UIButton *audioNextButton;
@property (nonatomic,strong) NSURL *songUrlPathFromVC;
@property (nonatomic,assign) NSArray *songUrlPathArray;

-(IBAction)playAudio:(id)sender;
-(IBAction)stopAudio:(id)sender;
-(IBAction)nextAudio:(id)sender;
-(IBAction)slide:(id)sender;


@end

NS_ASSUME_NONNULL_END
