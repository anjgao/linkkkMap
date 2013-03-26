//
//  UICentre.h
//  linkkkMap
//
//  Created by andregao on 13-3-22.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICentre : NSObject
@property(weak,nonatomic)    UIWindow * window;
-(id)initWithWindow:(UIWindow *) window;
-(void)start;
@end
