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

@end

NS_ASSUME_NONNULL_END
