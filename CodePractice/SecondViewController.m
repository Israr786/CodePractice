//
//  SecondViewController.m
//  CodePractice
//
//  Created by Apple on 3/28/18.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "SecondViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SongListTableViewController.h"


@interface SecondViewController (){
    
    NSURLSession * session;
     NSURLSessionDownloadTask *task;
    AVAudioPlayer *audioPlayer;
    
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    _downloadwebView= [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    _downloadwebView.navigationDelegate = self;
    NSURL *nsurl=[NSURL URLWithString:@"https://ytmp3.cc/"];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_downloadwebView loadRequest:nsrequest];
    [self.view addSubview:_downloadwebView];
   // [self.view addSubview:_downloadButton];
    
    NSLog(@"Git practise");
    

}


//Webview Start/Finish Request
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"didStartProvisionalNavigation: %@", navigation);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didReceiveServerRedirectForProvisionalNavigation: %@", navigation);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation: %@navigation, error: %@", navigation, error);
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation: %@", navigation);
}

- (void)webView:(WKWebView *)webView didFinishLoadingNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"didFinishLoadingNavigation: %@", navigation);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailNavigation: %@, error %@", navigation, error);
   NSLog(@"URL %@",error.userInfo[NSErrorFailingURLStringKey]);
    
 //   [self dismissViewControllerAnimated:YES completion:nil];
    _songNameList = [[NSMutableArray alloc]init];
    
    //1
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",error.userInfo[NSErrorFailingURLStringKey]]];
    
    // 2
    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession]
                                                   downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                       NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse *)response;
                                                       NSString *attachmentName = httpresponse.allHeaderFields[@"Content-Disposition"];
                                                       NSString *songNAme = [attachmentName substringFromIndex:22];
                                                       NSString *str = [songNAme substringToIndex:[songNAme length] -1];
                                                       NSLog(@"sonGName-- %@",str);
                                                
                                                       NSData *soundData = [NSData dataWithContentsOfURL:location];
                                                       NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                                                                  NSUserDomainMask, YES) objectAtIndex:0]
                                                                             stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",str]];
                                                       [soundData writeToFile:filePath atomically:YES];
                                                       
                                                       [_songListWithPath setValue:filePath forKeyPath:filePath];
                                                  //     [_songsPath addObject:filePath];
                                                 //      NSLog(@"%@", [_songListWithPath objectForKey:filePath]);
                                                      
                                                       NSLog(@"%@ SONg Path ",filePath);
                                                   }];
    // 4
    [downloadPhotoTask resume];
    
}

- (void)_webViewWebProcessDidCrash:(WKWebView *)webView {
    NSLog(@"WebContent process crashed; reloading");
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    
    if (!navigationAction.targetFrame.isMainFrame) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [_downloadwebView loadRequest:navigationAction.request];
        
    }
    return nil;
}

- (void)webView:(WKWebView *)webView didFinishNavigation: (WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"didFinish: %@; stillLoading:%@", [_downloadwebView URL], (_downloadwebView.loading?@"NO":@"YES"));
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse");
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if (decisionHandler) {
        decisionHandler(WKNavigationActionPolicyAllow);
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
