//
//  SecondViewController.h
//  CodePractice
//
//  Created by Apple on 3/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface SecondViewController : UIViewController<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,assign) NSDictionary *songListWithPath;
@property (nonatomic,assign) NSMutableArray *songsPath;
@property (nonatomic,assign) NSMutableArray *songNameList;

@property (nonatomic,strong) IBOutlet WKWebView *downloadwebView;

@end
