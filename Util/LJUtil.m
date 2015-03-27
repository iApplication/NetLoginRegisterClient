//
//  LJUtil.m
//  LoginRegister
//
//  Created by locky1218 on 15-3-22.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import "LJUtil.h"
#import <UIKit/UIKit.h>

@implementation LJUtil

+ (void)alert:(NSString *)msg
{
    UIAlertView * alertmsg = [[UIAlertView alloc]initWithTitle:@"友情提示" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alertmsg show];
}

+ (NSString *)trim:(NSString *)_str
{
    return [_str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
@end
