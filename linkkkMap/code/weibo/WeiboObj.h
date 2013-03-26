//
//  WeiboObj.h
//  linkkkMap
//
//  Created by andregao on 13-3-25.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SinaWeibo.h"

#define NotificationWeiboLoginOK     @"NotificationWeiboLoginOK"

@interface WeiboObj : NSObject
@property(strong,nonatomic) SinaWeibo * sinaweibo;

-(void)handleOpenURL:(NSURL *)url;
-(void)applicationDidBecomeActive;

-(void)login;
-(BOOL)isLogin;
@end
