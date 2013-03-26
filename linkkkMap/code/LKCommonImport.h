//
//  LKCommonImport.h
//  linkkkMap
//
//  Created by andregao on 13-3-22.
//  Copyright (c) 2013年 linkkk.com. All rights reserved.
//

#ifndef linkkkMap_LKCommonImport_h
#define linkkkMap_LKCommonImport_h

#import "UICentre.h"
#import "LogicCentre.h"
#import "LKAppDelegate.h"

#define LK_APP      ((LKAppDelegate*)[UIApplication sharedApplication].delegate)
#define LK_UI       LK_APP.objUICentre
#define LK_LOGIC    LK_APP.objLogicCentre
#define LK_WEIBO    (LK_LOGIC).weiboObj

#endif
