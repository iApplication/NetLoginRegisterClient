//
//  ViewController.m
//  NetLoginRegisterClient
//
//  Created by locky1218 on 15-3-26.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import "ViewController.h"
#import "LJUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//get同步登录
- (IBAction)loginTap:(UIButton *)sender {
    //有效性检查
    NSString * username = self.username.text;
    NSString * userpwd = self.userpwd.text;
    username = [LJUtil trim:username];
    userpwd = [LJUtil trim:userpwd];
    if([username isEqualToString:@""])
    {
        [LJUtil alert:@"账号不能为空。"];
        self.username.text = @"";
        [self.username becomeFirstResponder];
        return;
    }
    if([userpwd isEqualToString:@""])
    {
        [LJUtil alert:@"密码不能为空。"];
        self.userpwd.text = @"";
        [self.userpwd becomeFirstResponder];
        return;
    }
    
    //url  http://192.168.0.103/loginregister/register.php?username=3333&userpwd=3333
    NSString * urlPath = [NSString stringWithFormat:@"http://192.168.0.103/loginregister/GET/loginregister.php?username=%@&userpwd=%@&action=login", username, userpwd];
    //NSLog(@"%@", urlPath);
    NSURL * urlLoginRegister = [NSURL URLWithString:urlPath];
    NSURLRequest * loginRegisterRequest = [NSURLRequest requestWithURL:urlLoginRegister];
    NSData * data = [NSURLConnection sendSynchronousRequest:loginRegisterRequest returningResponse:nil error:nil];
    if(nil == data)//当请求不到网络是回返回nil，而网址错误不会返回nil
    {
        [LJUtil alert:@"连接到服务器失败，请检查网络连接"];
        NSLog(@"连接到服务器失败，请检查网络连接。");
    }
    else
    {
        NSString * responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", responseData);
        NSRange range = [responseData rangeOfString:@"success!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"登录成功！"];
            return;
        }
        [LJUtil alert:@"登录失败！"];
    }

}

//get同步注册
- (IBAction)registerTap:(UIButton *)sender {
    //有效性检查
    NSString * username = self.username.text;
    NSString * userpwd = self.userpwd.text;
    username = [LJUtil trim:username];
    userpwd = [LJUtil trim:userpwd];
    if([username isEqualToString:@""])
    {
        [LJUtil alert:@"账号不能为空。"];
        self.username.text = @"";
        [self.username becomeFirstResponder];
        return;
    }
    if([userpwd isEqualToString:@""])
    {
        [LJUtil alert:@"密码不能为空。"];
        self.userpwd.text = @"";
        [self.userpwd becomeFirstResponder];
        return;
    }
    
    //url  http://192.168.0.103/loginregister/register.php?username=3333&userpwd=3333
    NSString * urlPath = [NSString stringWithFormat:@"http://192.168.0.103/loginregister/GET/loginregister.php?username=%@&userpwd=%@&action=register", username, userpwd];
    //NSLog(@"%@", urlPath);
    NSURL * urlLoginRegister = [NSURL URLWithString:urlPath];
    NSURLRequest * loginRegisterRequest = [NSURLRequest requestWithURL:urlLoginRegister];
    NSData * data = [NSURLConnection sendSynchronousRequest:loginRegisterRequest returningResponse:nil error:nil];
    if(nil == data)//当请求不到网络是回返回nil，而网址错误不会返回nil
    {
        [LJUtil alert:@"连接到服务器失败，请检查网络连接"];
        NSLog(@"连接到服务器失败，请检查网络连接。");
    }
    else
    {
        NSString * responseData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@", responseData);
        NSRange range = [responseData rangeOfString:@"success!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"注册成功！"];
            return;
        }
        range = [responseData rangeOfString:@"exist!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"注册失败，当前用户已存在"];
            return;
        }
        [LJUtil alert:@"注册失败，请稍后再试"];
    }
    
}

//数据量大的时候提倡用异步
//get异步登录
- (IBAction)asynLoginTap:(UIButton *)sender {
    method = 1;
    //有效性检查
    NSString * username = self.username.text;
    NSString * userpwd = self.userpwd.text;
    username = [LJUtil trim:username];
    userpwd = [LJUtil trim:userpwd];
    if([username isEqualToString:@""])
    {
        [LJUtil alert:@"账号不能为空。"];
        self.username.text = @"";
        [self.username becomeFirstResponder];
        return;
    }
    if([userpwd isEqualToString:@""])
    {
        [LJUtil alert:@"密码不能为空。"];
        self.userpwd.text = @"";
        [self.userpwd becomeFirstResponder];
        return;
    }
    
    //url  http://192.168.0.103/loginregister/register.php?username=3333&userpwd=3333
    NSString * urlPath = [NSString stringWithFormat:@"http://192.168.0.103/loginregister/GET/loginregister.php?username=%@&userpwd=%@&action=login", username, userpwd];
    //NSLog(@"%@", urlPath);
    NSURL * urlLoginRegister = [NSURL URLWithString:urlPath];
    NSURLRequest * loginRegisterRequest = [NSURLRequest requestWithURL:urlLoginRegister];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:loginRegisterRequest delegate:self];
    if(nil == conn)
    {
        [LJUtil alert:@"连接到服务器失败，请稍后再试！"];
    }
    else//测试了一下，没网的时候也是连接成功的
    {
        NSLog(@"连接创建成功！");
        rcvData = [[NSMutableData alloc]init];
    }
    
    
   
}

//有响应--有数据返回来了
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"begin receive data!");
    [rcvData setLength:0];
}

//接收数据--根据数据量大小，可能产生多次
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"receive data!");
    [rcvData appendData:data];
}

//数据接收完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finish receive data!");
    NSString * rcvStr = [[NSString alloc]initWithData:rcvData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", rcvStr);
    if(1 == method)//登录
    {
        NSRange range = [rcvStr rangeOfString:@"success!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"登录成功"];
            return;
        }
        else
        {
            [LJUtil alert:@"登录失败"];
            return;
        }
    }
    else if(0 == method)//注册
    {
        NSRange range = [rcvStr rangeOfString:@"success!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"注册成功"];
            return;
        }
        range = [rcvStr rangeOfString:@"exist!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"账号已存在"];
            return;
        }
        [LJUtil alert:@"注册失败，请稍后再试"];
    }
    
}

//接收数据发生错误
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"receive error!");
}

//get异步注册
- (IBAction)asynRegisterTap:(UIButton *)sender {
    method = 0;
    //有效性检查
    NSString * username = self.username.text;
    NSString * userpwd = self.userpwd.text;
    username = [LJUtil trim:username];
    userpwd = [LJUtil trim:userpwd];
    if([username isEqualToString:@""])
    {
        [LJUtil alert:@"账号不能为空。"];
        self.username.text = @"";
        [self.username becomeFirstResponder];
        return;
    }
    if([userpwd isEqualToString:@""])
    {
        [LJUtil alert:@"密码不能为空。"];
        self.userpwd.text = @"";
        [self.userpwd becomeFirstResponder];
        return;
    }
    
    //url  http://192.168.0.103/loginregister/register.php?username=3333&userpwd=3333
    NSString * urlPath = [NSString stringWithFormat:@"http://192.168.0.103/loginregister/GET/loginregister.php?username=%@&userpwd=%@&action=register", username, userpwd];
    //NSLog(@"%@", urlPath);
    NSURL * urlLoginRegister = [NSURL URLWithString:urlPath];
    NSURLRequest * loginRegisterRequest = [NSURLRequest requestWithURL:urlLoginRegister];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:loginRegisterRequest delegate:self];
    if(nil == conn)
    {
        [LJUtil alert:@"连接到服务器失败，请稍后再试！"];
    }
    else//测试了一下，没网的时候也是连接成功的
    {
        NSLog(@"连接创建成功！");
        rcvData = [[NSMutableData alloc]init];
    }
    
}

- (IBAction)closeKeyboard:(id)sender {
}

//post同步登录
- (IBAction)postLoginTap:(UIButton *)sender {
    //有效性检查
    NSString * username = self.username.text;
    NSString * userpwd = self.userpwd.text;
    username = [LJUtil trim:username];
    userpwd = [LJUtil trim:userpwd];
    if([username isEqualToString:@""])
    {
        [LJUtil alert:@"账号不能为空。"];
        self.username.text = @"";
        [self.username becomeFirstResponder];
        return;
    }
    if([userpwd isEqualToString:@""])
    {
        [LJUtil alert:@"密码不能为空。"];
        self.userpwd.text = @"";
        [self.userpwd becomeFirstResponder];
        return;
    }
    
    //url  http://192.168.0.103/loginregister/register.php?username=3333&userpwd=3333
    NSString * urlPath = [NSString stringWithFormat:@"http://192.168.0.103/loginregister/POST/loginregister.php"];
    NSURL * url = [NSURL URLWithString:urlPath];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];//有缓存和超时时间
    
    [request setHTTPMethod:@"post"];
    
    NSString * strParams = [NSString stringWithFormat:@"username=%@&userpwd=%@&action=login", username, userpwd];
    
    NSData * data = [strParams dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData * recvData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(nil == recvData)
    {
        [LJUtil alert:@"post登录连接失败"];
    }
    else
    {
        NSString * rcvStr = [[NSString alloc]initWithData:recvData encoding:NSUTF8StringEncoding];
        NSRange range = [rcvStr rangeOfString:@"success!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"登录成功"];
            return;
        }
        else
        {
            [LJUtil alert:@"登录失败"];
            return;
        }
    }
}

//post同步注册
- (IBAction)postRegisterTap:(UIButton *)sender {
    //有效性检查
    NSString * username = self.username.text;
    NSString * userpwd = self.userpwd.text;
    username = [LJUtil trim:username];
    userpwd = [LJUtil trim:userpwd];
    if([username isEqualToString:@""])
    {
        [LJUtil alert:@"账号不能为空。"];
        self.username.text = @"";
        [self.username becomeFirstResponder];
        return;
    }
    if([userpwd isEqualToString:@""])
    {
        [LJUtil alert:@"密码不能为空。"];
        self.userpwd.text = @"";
        [self.userpwd becomeFirstResponder];
        return;
    }
    
    //url  http://192.168.0.103/loginregister/register.php?username=3333&userpwd=3333
    NSString * urlPath = [NSString stringWithFormat:@"http://192.168.0.103/loginregister/POST/loginregister.php"];
    NSURL * url = [NSURL URLWithString:urlPath];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];//有缓存和超时时间
    
    [request setHTTPMethod:@"post"];
    
    NSString * strParams = [NSString stringWithFormat:@"username=%@&userpwd=%@&action=register", username, userpwd];
    
    NSData * data = [strParams dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSData * recvData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(nil == recvData)
    {
        [LJUtil alert:@"post登录连接失败"];
    }
    else
    {
        NSString * rcvStr = [[NSString alloc]initWithData:recvData encoding:NSUTF8StringEncoding];
        NSRange range = [rcvStr rangeOfString:@"success!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"注册成功"];
            return;
        }
        range = [rcvStr rangeOfString:@"exist!"];
        if(range.location != NSNotFound)
        {
            [LJUtil alert:@"账号已存在"];
            return;
        }
        [LJUtil alert:@"注册失败，请稍后再试"];
    }
}
@end
