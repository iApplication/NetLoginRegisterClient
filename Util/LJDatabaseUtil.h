//
//  LJDatabaseUtil.h
//  LoginRegister
//
//  Created by locky1218 on 15-3-23.
//  Copyright (c) 2015年 locky1218. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface LJDatabaseUtil : NSObject

+ (sqlite3 *)db;

//打开数据库
+ (BOOL)openDatabasePath:(NSString *)_path withDatabaseName:(NSString *)_dbname;

//运行一个sql
+ (BOOL)execSQL:(NSString *)_sql;

+ (int)bindSelectSQL:(NSString *)_sql forParams:(id)_param,...;

+ (int)bindInsertSQL:(NSString *)_sql forParams:(id)_param,...;

@end
