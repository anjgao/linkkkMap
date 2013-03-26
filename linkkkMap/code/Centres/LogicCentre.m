//
//  LogicCentre.m
//  linkkkMap
//
//  Created by andregao on 13-3-25.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import "LogicCentre.h"
#import "WeiboObj.h"

@interface LogicCentre ()

@end

@implementation LogicCentre

-(id)init
{
    self = [super init];
    
    _weiboObj = [[WeiboObj alloc] init];
    
    return self;
}

@end
