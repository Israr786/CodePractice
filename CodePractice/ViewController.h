//
//  ViewController.h
//  CodePractice
//
//  Created by Apple on 3/26/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "PlayerViewController.h"


@interface ViewController : UIViewController<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong) IBOutlet WKWebView *webView;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *downloadButton;
@property (nonatomic,strong) IBOutlet UIBarButtonItem *refreshButton;
@property (nonatomic,strong) PlayerViewController *playerVCMain;


-(IBAction)downloadSong:(id)sender;
-(IBAction)refreshPage:(id)sender;
-(IBAction)songListVC:(id)sender;


@end

