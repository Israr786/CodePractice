//
//  SongTableViewCell.h
//  CodePractice
//
//  Created by Apple on 3/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SongTableViewCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *songNameLabel;
@property(nonatomic,weak) IBOutlet UIButton *playButton;



@end
