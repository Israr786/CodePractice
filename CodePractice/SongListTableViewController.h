//
//  SongListTableViewController.h
//  CodePractice
//
//  Created by Apple on 3/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerViewController.h"

@interface SongListTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) IBOutlet UITableView *tableview;
@property(nonatomic,strong) PlayerViewController *playerVC;


@end
