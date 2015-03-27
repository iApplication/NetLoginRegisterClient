//
//  LJDatabaseUtil.m
//  LoginRegister
//
//  Created by locky1218 on 15-3-23.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import "LJDatabaseUtil.h"
#import "LJUtil.h"

static sqlite3 * db = NULL;//数据库变量
static sqlite3_stmt * stmt = NULL;//陈述变量

@implementation LJDatabaseUtil

+ (sqlite3 *)db
{
    return db;
}

+ (BOOL)openDatabasePath:(NSString *)_path withDatabaseName:(NSString *)_dbname
{
    NSString * path;
    path = [_path stringByAppendingPathComponent:_dbname];
    int result = sqlite3_open([path UTF8String], &db);
    if(SQLITE_OK != result)
    {
        [LJUtil alert:@"打开数据库失败"];
        return NO;
    }
    return YES;
}

+ (BOOL)execSQL:(NSString *)_sql
{
    //"create table if not exists t_user(username text not null, pwd text not null)";
    char * error;
    int result = sqlite3_exec(db, [_sql UTF8String], NULL, NULL, &error);
    if(SQLITE_OK != result)
    {
        [LJUtil alert:@"运行SQL失败！"];
        sqlite3_close(db);
        return NO;
    }
    return YES;
}

/**
 * brief：绑定一个SQL，并执行
 * in：第一个参数为SQL语句，其余为绑定的参数。最后参数多加一个nil，防止错误
 * out：返回1为select有结果，2为无结果，0为绑定失败
 */
+ (int)bindSelectSQL:(NSString *)_sql forParams:(id)_param,...
{
    /*获得所有参数*/
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    if (_param)
    {
        //将第一个参数添加到array
        [argsArray addObject:_param];
        
        va_list params; //定义一个指向个数可变的参数列表指针；
        va_start(params, _param);//va_start  得到第一个可变参数地址,
        
        NSString *arg;
        while( (arg = va_arg(params, id)) )         //va_arg 指向下一个参数地址
        {
            if (arg)
            {
                [argsArray addObject:arg];
            }
            else//为nil时跳出
            {
                break;
            }
        }
        va_end(params);         //置空
    }
    
    //prepare
    sqlite3_finalize(stmt);//陈述先释放，然后可以用
    const char * sql = [_sql UTF8String];//e.g. "select * from t_user where username=? and pwd=?";
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if(SQLITE_OK != result)
    {
        [LJUtil alert:@"准备失败，请稍后再试"];
        return 0;
    }
    
    //bind
    int index = 1;
    for (id param in argsArray)
    {
        
        int result;
        if([param isKindOfClass:[NSString class]])
        {
            result = sqlite3_bind_text(stmt, index, [param UTF8String], -1, NULL);
        }
        else if([param isKindOfClass:[NSNumber class]])
        {
            result = sqlite3_bind_int(stmt, index, [param intValue]);
        }
        else
        {
            //do nothing
        }
        
        if(SQLITE_OK != result)
        {
            [LJUtil alert:@"账号绑定失败，请稍后再试"];
            return 0;
        }
        
        index++;
    }
    
    //操作step
    result =sqlite3_step(stmt);
    if(SQLITE_ROW == result)//返回一行
    {
        return 1;
    }
    else if(SQLITE_DONE == result)//全部完成
    {
        return 2;
    }
    else
    {
        return result;
    }

}

/**
 * brief：绑定一个SQL，并执行
 * in：第一个参数为SQL语句，其余为绑定的参数。最后参数多加一个nil，防止错误
 * out：返回1为insert成功，0为绑定失败
 */
+ (int)bindInsertSQL:(NSString *)_sql forParams:(id)_param,...
{
    /*获得所有参数*/
    NSMutableArray *argsArray = [[NSMutableArray alloc] init];
    if (_param)
    {
        //将第一个参数添加到array
        [argsArray addObject:_param];
        
        va_list params; //定义一个指向个数可变的参数列表指针；
        va_start(params, _param);//va_start  得到第一个可变参数地址,
        
        NSString *arg;
        while( (arg = va_arg(params, id)) )         //va_arg 指向下一个参数地址
        {
            if (arg)
            {
                [argsArray addObject:arg];
            }
            else//为nil时跳出
            {
                break;
            }
        }
        va_end(params);         //置空
    }
    
    //prepare
    sqlite3_finalize(stmt);//陈述先释放，然后可以用
    const char * sql = [_sql UTF8String];//e.g. "select * from t_user where username=? and pwd=?";
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if(SQLITE_OK != result)
    {
        [LJUtil alert:@"准备失败，请稍后再试"];
        return 0;
    }
    
    //bind
    int index = 1;
    for (id param in argsArray)
    {
        
        int result;
        if([param isKindOfClass:[NSString class]])
        {
            result = sqlite3_bind_text(stmt, index, [param UTF8String], -1, NULL);
        }
        else if([param isKindOfClass:[NSNumber class]])
        {
            result = sqlite3_bind_int(stmt, index, [param intValue]);
        }
        else
        {
            //do nothing
        }
        
        if(SQLITE_OK != result)
        {
            [LJUtil alert:@"账号绑定失败，请稍后再试"];
            return 0;
        }
        
        index++;
    }
    
    //操作step
    result =sqlite3_step(stmt);
    if(SQLITE_DONE == result)//insert成功
    {
        return 1;
    }
    else
    {
        return result;
    }
    
}

@end
