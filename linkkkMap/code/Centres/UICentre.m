//
//  UICentre.m
//  linkkkMap
//
//  Created by andregao on 13-3-22.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import "UICentre.h"
#import "LoginVC.h"
#import "PlaceListVC.h"

@implementation UICentre
{
    
}

-(id)initWithWindow:(UIWindow *) window
{
    self = [super init];
    
    _window = window;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOK:) name:NotificationLKLoginOK object:nil];
    
    return self;
}

-(void)start
{
    if ([LK_WEIBO isLogin]) {
        [_window setRootViewController:[[PlaceListVC alloc] init]];
    }
    else {
        [_window setRootViewController:[[LoginVC alloc] init]];
    }
}

#pragma mark - inner
- (void)loginOK:(NSNotification *)notification {
    [_window setRootViewController:[[PlaceListVC alloc] init]];
}

@end
