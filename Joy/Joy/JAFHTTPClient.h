//
//  JAFHTTPClient.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "AFHTTPClient.h"

@interface JAFHTTPClient : AFHTTPClient

#define NETWORK_ERROR   @"网络异常"

#define USER_NAME           @"username"
#define COMPANY_NAME        @"companyname"
#define BASE_URL @"http://www.joy121.com/sys/ajaxpage/app"
#define IMAGE_URL @"http://www.joy121.com/SYS/Files/img/"

- (void)saveUserName:(NSString *)userName;
- (NSString *)userName;
- (void)saveCompanyName:(NSString *)companyName;
- (NSString *)companyName;
+ (void)signOut;
+ (BOOL)bLogin;

+ (instancetype)shared;

/**
 * @brief 用户登录
 *
 * @param username
 * @param password
 */
- (void)signIn:(NSString *)username
      password:(NSString *)password
     withBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 用户信息
 *
 */
- (void)userInfoWithBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 用户购买历史
 *
 */
- (void)userBuyHistory:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 用户积分
 *
 */
- (void)userScore:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 修改密码
 *
 */
- (void)changePwd:(NSString *)oldPwd
           newPwd:(NSString *)newPwd
        withBlock:(void(^)(NSDictionary *result, NSError *error))block;


/**
 * @brief 用户订单列表
 *
 */
- (void)userOrderList:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 首页宣传图片
 * 
 */
- (void)frontPicWithBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 用户可订购套餐的列表
 *
 */
- (void)userPackageList:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 套餐详情
 *
 * @param commsetid ID
 */
- (void)packageDetail:(NSString *)cid
          withBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 提交订单
 *
 * @param pid 
 * @param pType
 * @param receiver
 * @param receAdd
 * @param recPhone
 */
- (void)orderSubmit:(NSString *)pid
               type:(NSString *)type
               name:(NSString *)name
            address:(NSString *)address
              phone:(NSString *)phone
               mark:(NSString *)mark
          withBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 公告
 *
 */
- (void)companyNotice:(NSString *)companyName
            withBlock:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 活动列表
 *
 */
- (void)eventList:(void(^)(NSDictionary *result, NSError *error))block;

/**
 * @brief 加入活动
 *
 */
- (void)joinEvent:(NSString *)eventId
              fee:(NSString *)fee
        withBlock:(void(^)(NSDictionary *result, NSError *error))block;
@end
