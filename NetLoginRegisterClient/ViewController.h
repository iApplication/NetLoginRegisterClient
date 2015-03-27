//
//  ViewController.h
//  NetLoginRegisterClient
//
//  Created by locky1218 on 15-3-26.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDataDelegate>
{
    NSMutableData * rcvData;
    int method;//是0代表get方法的异步注册，是1代表get方法的异步登录
}
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *userpwd;

- (IBAction)loginTap:(UIButton *)sender;
- (IBAction)registerTap:(UIButton *)sender;
- (IBAction)asynLoginTap:(UIButton *)sender;
- (IBAction)asynRegisterTap:(UIButton *)sender;
- (IBAction)closeKeyboard:(id)sender;
- (IBAction)postLoginTap:(UIButton *)sender;
- (IBAction)postRegisterTap:(UIButton *)sender;
@end

