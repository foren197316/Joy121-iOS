//
//  JAFHTTPClient.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JAFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import <CommonCrypto/CommonDigest.h>

#define KEY   @"wang!@#$%"

@implementation JAFHTTPClient

+ (instancetype)shared
{
    static JAFHTTPClient *client;
    if (!client) {
        client = [[JAFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    return client;
}

- (void)saveUserName:(NSString *)userName
{
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:USER_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userName
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:USER_NAME];
}

- (void)saveCompanyName:(NSString *)companyName
{
    [[NSUserDefaults standardUserDefaults] setObject:companyName forKey:COMPANY_NAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)companyName
{
	return [[NSUserDefaults standardUserDefaults] stringForKey:COMPANY_NAME];
}

+ (void)signOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)bLogin
{
	NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:USER_NAME];
	return userName ? YES : NO;
}

- (NSString *)md5WithString:(NSString *)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];
}

- (void)signIn:(NSString *)username
      password:(NSString *)password
     withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSString *deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    if (!deviceToken) {
        deviceToken = @"null";
    }
    NSString *token = [NSString stringWithFormat:@"%@%@", username, KEY];
    NSDictionary *param = @{@"action" : @"login", @"token" : [self md5WithString:token],
                            @"json" : [self createJsonStringWithParam:@{@"loginname": username, @"loginpwd" : password, @"imeino" : deviceToken}]};
    [self getPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (NSString *)getToken
{
    NSString *token = [NSString stringWithFormat:@"%@%@", [self userName], KEY];
    return [self md5WithString:token];
}

- (void)userInfoWithBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"user_info", @"token" : [self getToken],
                            @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
    [self getPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)userBuyHistory:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"user_order", @"token" : [self getToken],
                            @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
    [self getPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)userScore:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"point_his", @"token" : [self getToken],
                            @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
    [self getPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)changePwd:(NSString *)oldPwd
           newPwd:(NSString *)newPwd
        withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"user_cpwd", @"token" : [self getToken],
                            @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"ologinpwd" : oldPwd, @"nloginpwd" : newPwd}]};
    [self getPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)userOrderList:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"user_order", @"token" : [self getToken],
                            @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
    [self getPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


- (void)frontPicWithBlock:(void (^)(NSDictionary *, NSError *))block
{
    NSDictionary *param = @{@"action" : @"fp_pic" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)userPackageList:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"fp_benefit" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)packageDetail:(NSString *)cid
          withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"bf_single" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"commsetid" : cid}]};
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)orderSubmit:(NSString *)pid
               type:(NSString *)type
               name:(NSString *)name
            address:(NSString *)address
              phone:(NSString *)phone
               mark:(NSString *)mark
          withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"order_submit" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"pId" : pid, @"pType" : type, @"receiver" : name, @"recAdd" : address, @"recPhone" : phone, @"pRemark" : mark}]};
    NSLog(@"%@", param);
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)companyNotice:(NSString *)companyName
            withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSString *companyId = companyName ? companyName : [self companyName];
    NSDictionary *param = @{@"action" : @"comp_post" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"company" : companyId}]};
    NSLog(@"%@", param);
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)eventList:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"comp_activity" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"company" : [self companyName]}]};
    NSLog(@"%@", param);
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)joinEvent:(NSString *)eventId
              fee:(NSString *)fee
        withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"comp_act_join" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"actid" : eventId, @"actfee" : fee}]};
    NSLog(@"%@", param);
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)surList:(NSString *)companyName
      withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSString *companyId = companyName ? companyName : [self companyName];
    NSDictionary *param = @{@"action" : @"comp_survey" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"company" : companyId}]};
    NSLog(@"%@", param);
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)voteSubmit:(NSString *)surId
           answers:(NSString *)answers
         withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"comp_survey_a" , @"token" : [self getToken], @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"surveyid" : surId, @"answers" : answers}]};
    NSLog(@"%@", param);
    [self postPath:@"Msg.ashx" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


#pragma mark -
#pragma mark Tool method
- (NSString *)createJsonStringWithParam:(NSDictionary *)param
{
    NSArray *keys = [param allKeys];
    NSMutableString *json = [@"{" mutableCopy];
    for (int i = 0; i < [keys count]; i ++) {
        NSString *keyValue = [NSString stringWithFormat:@"\"%@\":\"%@\"", keys[i], param[keys[i]]];
        [json appendString:keyValue];
        if ((i + 1) != [keys count]) {
            [json appendString:@","];
        }
    }
    [json appendString:@"}"];
    return json;
}

- (id)jsonValue:(id)JSON
{
	if (![JSON isKindOfClass:[NSData class]] || !JSON) {
		return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:JSON options:NSJSONReadingAllowFragments error:nil];
}

@end

