//
//  ViewController.m
//  CodePractice
//
//  Created by Apple on 3/26/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "SongListTableViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   //initialise player
    _playerVCMain = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    _webView= [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    _webView.navigationDelegate = self;
    NSURL *nsurl=[NSURL URLWithString:@"http://www.youtube.com"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webView loadRequest:nsrequest];
    [self.view addSubview:_webView];
}

-(IBAction)downloadSong:(id)sender{
    
   
    SecondViewController *secondVC = [[SecondViewController alloc]init];
   [self.navigationController pushViewController:secondVC animated:YES];
//   [self presentViewController:secondVC animated:YES completion:nil];
    

}

-(IBAction)refreshPage:(id)sender {
    [self viewDidLoad];
}


// our two sum function which will return
// all pairs in the array that sum up to S

-(IBAction)songListVC:(id)sender {
    SongListTableViewController *songListVC = [[SongListTableViewController alloc]initWithNibName:@"SongListTableViewController" bundle:nil];
    songListVC.playerVC = _playerVCMain;
    [self.navigationController pushViewController:songListVC animated:YES];
    
    
  //  [self presentViewController:songListVC animated:YES completion:nil];
  
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
