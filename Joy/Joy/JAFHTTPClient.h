//
//  JAFHTTPClient.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "AFHTTPClient.h"

@interface JAFHTTPClient : AFHTTPClient

#define USER_NAME  @"username"

- (void)saveUserName:(NSString *)userName;
- (NSString *)userName;
+ (void)signOut;

+ (instancetype)shared;

/*
 * @brief 用户登录
 *
 * @param username
 * @param password
 */
- (void)signIn:(NSString *)username
      password:(NSString *)password
     withBlock:(void(^)(NSDictionary *result, NSError *error))block;

/*
 * @brief 用户信息
 *
 */
- (void)userInfoWithBlock:(void(^)(NSDictionary *result, NSError *error))block;

/*
 * @brief 用户购买历史
 *
 */
- (void)userBuyHistory:(void(^)(NSDictionary *result, NSError *error))block;

/*
 * @brief 用户积分
 *
 */
- (void)userScore:(void(^)(NSDictionary *result, NSError *error))block;

/*
 * @brief 首页宣传图片
 * 
 */
- (void)frontPicWithBlock:(void(^)(NSDictionary *result, NSError *error))block;

/*
 * @brief 用户可订购套餐的列表
 *
 */
- (void)userOrderList:(void(^)(NSDictionary *result, NSError *error))block;

/*
 * @brief 套餐详情
 *
 * @param commsetid ID
 */
- (void)orderDetail:(NSString *)cid
          withBlock:(void(^)(NSDictionary *result, NSError *error))block;

@end
