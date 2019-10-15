//
//  UIWebViewController.m
//  
//
//  Created by ping on 2019/9/19.
//

#import "UIWebViewController.h"
#import <WebKit/WebKit.h>
@interface UIWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *myWebView;
@property (nonatomic, strong) NSString *onlinePlayUrl;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    btn.frame = CGRectMake(10, 20, 44, 44);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //此处在这里要解析三次网页
    UIWebView *webView =  [[UIWebView alloc] initWithFrame:CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height-64)];
    
    
    NSString *origin = @"https://www.yunbtv.com/vodsearch/-------------.html?wd=死侍2";
    origin =  [origin stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:origin]];//https://www.yunbtv.com/vodsearch/-------------.html?wd=死侍2
    [webView loadRequest:request];
    webView.delegate = self; //记得遵循代理 UIWebViewDelegate
    [self.view addSubview:webView];
    self.myWebView = webView;
}

- (void)backBtn:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完成才能获取---%@",webView.request.URL);
    
    NSString *webViewUrl = [NSString stringWithFormat:@"%@",webView.request.URL];
//
//    NSString *doc     = @"document.body.outerHTML";
//    NSString *htmlStr = [webView stringByEvaluatingJavaScriptFromString:doc];
//    NSLog(@"cfy---这个是第二种方法-%@",htmlStr);
    
    if ([webViewUrl containsString:@"vodsearch"]) {
        //获取当前的视频元素的a标签的herf
        NSString *hrefJS     = @"document.getElementsByClassName('media-wrapper')[0].getElementsByTagName('a')[0].pathname";
        NSString *hrefStr = [webView stringByEvaluatingJavaScriptFromString:hrefJS];
        NSLog(@"cfy---这个是获取a标签的href--%@",hrefStr);
        //  /voddetail/sishi2woaiwojia.html
        
        if ([hrefStr containsString:@"voddetail"]) {
            //这里表示进入的是详情页面
            //        NSString *detailStr = [NSString stringWithFormat:@"https://www.yunbtv.com%@",hrefStr];
            
            //https://www.yunbtv.com/vodplay/sishi2woaiwojia-1-1.html
            NSString *playStr = [NSString stringWithFormat:@"%@",@"https://www.yunbtv.com/vodplay/sishi2woaiwojia-1-1.html"];
            
            //这里拿到这个地址以后，再次请求详情页面获取下一个播放页面的a标签
            NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:playStr]];
            [self.myWebView loadRequest:request];
        }
    }
    
    
    if ([webViewUrl containsString:@"vodplay"]) {
        //获取播放页面的播放地址
        NSString *playUrlJS     = @"document.getElementsByClassName('MacPlayer')[0].getElementsByTagName('table')[0].getElementsByTagName('td')[0].getElementsByTagName('iframe')[0].src";
        NSString *playUrlStr = [webView stringByEvaluatingJavaScriptFromString:playUrlJS];
        NSLog(@"cfy---这个是播放页面的播放地址--%@",playUrlStr); // https://player.yunbtv.com/m3u8/index.php?url=https://iqiyi.com-l-iqiyi.com/20190125/21294_36849822/index.m3u8
        
        self.onlinePlayUrl = [playUrlStr componentsSeparatedByString:@"?url="][1];
    }
    
}

@end
