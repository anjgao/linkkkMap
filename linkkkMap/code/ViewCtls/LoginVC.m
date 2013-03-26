//
//  LoginVC.m
//  linkkkMap
//
//  Created by andregao on 13-3-25.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import "LoginVC.h"
#import "ASIFormDataRequest.h"

@interface LoginVC ()

@end

@implementation LoginVC
{
    UIButton * _loginBtn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboLoginOK:) name:NotificationWeiboLoginOK object:nil];
	
    _loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginBtn.frame = CGRectMake(60, 200, 200, 40);
    [_loginBtn setTitle:@"新浪微博登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginBtnPressed:(UIButton*)loginBtn
{
    [LK_WEIBO login];
}

- (void)weiboLoginOK:(NSNotification *)notification
{
    _loginBtn.enabled = NO;
    
    [self lkLogin];
}

- (void)lkLogin
{
    NSURL * url = [NSURL URLWithString:[@"http://map.linkkk.com" stringByAppendingString:@"/v5/app/login/"]];
    ASIFormDataRequest* loginRequest = [ASIFormDataRequest requestWithURL:url];
    loginRequest.delegate = self;
    loginRequest.shouldRedirect = NO;
    
    SinaWeibo * sinaweibo = LK_WEIBO.sinaweibo;
    NSString * ed = [NSString stringWithFormat:@"%0.f",[sinaweibo.expirationDate timeIntervalSince1970]];
    [loginRequest setPostValue:sinaweibo.userID forKey:@"uid"];
    [loginRequest setPostValue:sinaweibo.accessToken forKey:@"access_token"];
    [loginRequest setPostValue:ed forKey:@"expires_in"];
    
    [loginRequest startAsynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * a = request.responseString;
//    if ([repObj.status isEqualToString:@"okay"]) {
//        [self saveXSRFToken:request.responseCookies];
//        LK_USER.userID = repObj.data.user_id;
//        [LK_USER storeUserName:_user andPW:_pw];
//        
//        [self.hud hide:YES];
//        [LK_UI loginSuccess];
//    }
//    else if ([repObj.status isEqualToString:@"oops"]) {
//        NSString * errStr;
//        if (repObj.invalidations.__all__[0]) {
//            errStr = repObj.invalidations.__all__[0];
//        }
//        else if (repObj.invalidations.login[0]) {
//            errStr = repObj.invalidations.login[0];
//        }
//        else if (repObj.invalidations.password[0]) {
//            errStr = repObj.invalidations.password[0];
//        }
//        
//        showHUDTip(self.hud, errStr);
//    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
//    LKLog([request responseString]);
//    LKLog([[request error] localizedDescription]);
}

-(void)saveXSRFToken:(NSArray*)cookies
{
//    for (NSHTTPCookie* cookie in cookies) {
//        if ([cookie.name isEqualToString:@"XSRF-TOKEN"]) {
//            LK_USER.xsrfToken = cookie.value;
//            break;
//        }
//    }
}


@end
