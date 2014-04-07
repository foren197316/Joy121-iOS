//
//  JAFHTTPClient.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JAFHTTPClient.h"
#import "AFJSONRequestOperation.h"

#define BASE_URL @"http://www.joy121.com/sys/ajaxpage/app"

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
    NSString *userName = [[NSUserDefaults standardUserDefaults] stringForKey:USER_NAME];
    return @"steven"; //TO DO:用做测试
//    return userName;
}

+ (void)signOut
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME];
}

- (void)signIn:(NSString *)username
      password:(NSString *)password
     withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"login",
                            @"json" : [self createJsonStringWithParam:@{@"loginname": username, @"loginpwd" : password}]};
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

- (void)userInfoWithBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"user_info",
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
    NSDictionary *param = @{@"action" : @"user_order",
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
    NSDictionary *param = @{@"action" : @"point_his",
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
    NSDictionary *param = @{@"action" : @"fp_pic" , @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
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

- (void)userOrderList:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"fp_benefit" , @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName]}]};
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

- (void)orderDetail:(NSString *)cid
          withBlock:(void(^)(NSDictionary *result, NSError *error))block
{
    NSDictionary *param = @{@"action" : @"bf_single" , @"json" : [self createJsonStringWithParam:@{@"loginname": [self userName], @"commsetid" : cid}]};
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

//"""http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=login&json={""loginname"":""steven"",""loginpwd"":""121""}

//http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=fp_pic&json={""loginname"":""steven""}
//
//http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=fp_benefit&json={""loginname"":""steven""}
//
//http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=bf_single&json={""loginname"":""steven"",""commsetid"":""22""}
//
//http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=user_info&json={""loginname"":""steven""}
//
//http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=user_order&json={""loginname"":""steven""}
//
//http://www.joy121.com/sys/ajaxpage/app/Msg.ashx?action=point_his&json={""loginname"":""steven""}"
@end

