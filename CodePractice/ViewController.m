//
//  ViewController.m
//  CodePractice
//
//  Created by Apple on 3/26/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    _webView= [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    _webView.navigationDelegate = self;
    NSURL *nsurl=[NSURL URLWithString:@"http://www.youtube.com"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webView loadRequest:nsrequest];
    [self.view addSubview:_webView];
    [self.view addSubview:_downloadButton];
  //  [self.navigationController initWithRootViewController:
  
}

-(IBAction)downloadSong:(id)sender{
    
   
    SecondViewController *secondVC = [[SecondViewController alloc]init];
 //   [self.navigationController pushViewController:secondVC animated:YES];
    
    [self presentViewController:secondVC animated:YES completion:nil];
    

}



// our two sum function which will return
// all pairs in the array that sum up to S


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
