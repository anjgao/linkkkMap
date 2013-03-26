//
//  WeiboObj.m
//  linkkkMap
//
//  Created by andregao on 13-3-25.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import "WeiboObj.h"
#import "SinaWeibo.h"

@interface WeiboObj() <SinaWeiboDelegate>

@end

@implementation WeiboObj

#define kAppKey             @"2279872707"
#define kAppSecret          @"e0a3ff6db611f960c7e3f1765407c9d7"
#define kAppRedirectURI     @"http://map.linkkk.com"

#pragma mark - SinaWeiboDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self storeAuthData];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWeiboLoginOK object:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    [self removeAuthData];
}

#pragma mark - outer
-(id)init
{
    self = [super init];
    
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    return self;
}

-(void)handleOpenURL:(NSURL *)url
{
    [_sinaweibo handleOpenURL:url];
}

-(void)applicationDidBecomeActive
{
    [_sinaweibo applicationDidBecomeActive];
}

-(void)login
{
    [_sinaweibo logIn];
}

-(BOOL)isLogin
{
    return [_sinaweibo isAuthValid];
}

#pragma mark - inner
- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              _sinaweibo.accessToken, @"AccessTokenKey",
                              _sinaweibo.expirationDate, @"ExpirationDateKey",
                              _sinaweibo.userID, @"UserIDKey",
                              _sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

@end
