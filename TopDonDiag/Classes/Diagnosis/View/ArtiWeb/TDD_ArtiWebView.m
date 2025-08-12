//
//  TDD_ArtiWebView.m
//  AD200
//
//  Created by 何可人 on 2022/5/23.
//

#import "TDD_ArtiWebView.h"
#import <WebKit/WebKit.h>

@interface TDD_ArtiWebView ()<WKNavigationDelegate>
@property (nonatomic, strong) WKWebView * loadWebView;
@end


@implementation TDD_ArtiWebView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = UIColor.tdd_viewControllerBackground;
        
        [self creatUI];
    }
    
    return self;
}

- (void)creatUI{
    WKWebView * loadWebView = [[WKWebView alloc] init];
    loadWebView.navigationDelegate = self;
    loadWebView.scrollView.bounces = false;
    [self addSubview:loadWebView];
    self.loadWebView = loadWebView;
    
    [loadWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setWebModel:(TDD_ArtiWebModel *)webModel
{
    
    _webModel = webModel;
    
    if (webModel.strPath.length > 0) {
        [self.loadWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:webModel.strPath]]];
    }else if (webModel.strContent.length > 0) {
        [self.loadWebView loadHTMLString:webModel.strContent baseURL:nil];
    }else {
        HLog(@"web没有数据");
    }
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
   
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}

@end
