//
//  JAFHTTPClient.m
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import "JAFHTTPClient.h"
#import "AFJSONRequestOperation.h"
#import "APService.h"
#import <CommonCrypto/CommonDigest.h>

#define USER_NAME @"username"
#define COMPANY_NAME @"companyname"
#define KEY @"wang!@#$%"
#define kAPIInterface @"ajaxpage/app/msg.ashx"
#define kAPIKeyAction @"action"
#define BASE_URL_STRING @"http://cloud.joy121.com/"
#define GOODS_PROPERTIES @"GOODS_PROPERTIES"

@implementation JAFHTTPClient

+ (instancetype)shared
{
    static JAFHTTPClient *client;
    if (!client) {
        client = [[JAFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL_STRING]];
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

+ (NSString *)imageURLString
{
	return [NSString stringWithFormat:@"%@%@", BASE_URL_STRING, @"files/img/"];
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
	
	NSDictionary *normalParameters = @{kAPIKeyAction : @"login", @"token" : [self md5WithString:token]};
	NSDictionary *jsonParameters = @{@"loginname": username, @"loginpwd" : password, @"imeino" : deviceToken};
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
		
    [self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
		NSDictionary *attributes = jsonValue[@"retobj"];
		NSString *accessCodes = attributes[@"AppAccessCodes"];
		NSArray *codes = [accessCodes componentsSeparatedByString:@","];
		[self savePushTags:codes];
        if (block) {
            block(jsonValue, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)savePushTags:(NSArray *)tags
{
	[[NSUserDefaults standardUserDefaults] setObject:tags forKey:@"push_tags"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)pushTags
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:@"push_tags"];
}

- (NSString *)getToken
{
    NSString *token = [NSString stringWithFormat:@"%@%@", [self userName], KEY];
    return [self md5WithString:token];
}

- (void)userInfoWithBlock:(void(^)(NSDictionary *attributes, NSError *error))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"user_info", @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
		NSDictionary *attributes = jsonValue[@"retobj"];
        if (block) {
            block(attributes, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)userBuyHistory:(void(^)(NSDictionary *result, NSError *error))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"user_order", @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];

    [self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"point_his", @"token" : [self getToken]};
	NSDictionary *jsonParamters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParamters];

    [self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"user_cpwd", @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"ologinpwd" : oldPwd, @"nloginpwd" : newPwd}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)myOrders:(void(^)(NSArray *multiAttributes, NSError *error))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"user_order", @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];

    [self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
        if (block) {
            block(jsonValue[@"retobj"], nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}


- (void)frontPicWithBlock:(void (^)(NSDictionary *, NSError *))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"fp_pic" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"fp_benefit" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"bf_single" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"commsetid" : cid}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"order_submit" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"pId" : pid, @"pType" : type, @"receiver" : name, @"recAdd" : address, @"recPhone" : phone, @"pRemark" : mark}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)noticesIsExpired:(BOOL)expired withBlock:(void(^)(NSArray *multiAttributes, NSError *error))block;
{
	NSNumber *isExpired = expired ? @(2) : @(1);
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comp_post" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginNameAndCompanyName:@{@"isexpired": isExpired}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];

    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
        if (block) {
            block(multiAttributes, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)eventsIsExpired:(BOOL)bExpired isTraining:(BOOL)bTraining withBlock:(void (^)(NSArray *multiAttributes, NSError *error))block;
{
	NSNumber *isExpired = bExpired ? @(2) : @(1);
	NSNumber *isTraining = bTraining ? @(2) : @(1);
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comp_activity" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginNameAndCompanyName:@{@"isexpired" : isExpired, @"acttype" : isTraining}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
        if (block) {
            block(multiAttributes, nil);
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comp_act_join" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"actid" : eventId, @"actfee" : fee}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];

    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)surveysIsExpired:(BOOL)expired withBlock:(void(^)(NSDictionary *result, NSError *error))block;
{
	NSNumber *isExpired = expired ? @(2) : @(1);
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comp_survey" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginNameAndCompanyName:@{@"isexpired" : isExpired}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comp_survey_a" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"surveyid" : surId, @"answers" : answers}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];

    [self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)companyModulesWithBlock:(void (^)(NSArray *multiAttributes, NSError *error))block;
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comp_modules" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginNameAndCompanyName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];

	[self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
        if (block) {
            block(multiAttributes, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void)storeCategoriesWithBlock:(void (^)(NSArray *multiAttributes, NSError *error))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comm_category" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginNameAndCompanyName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
	[self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
		if (block) {
			block(multiAttributes, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) {
			block(nil, error);
		}
	}];
}

- (void)storeGoodsOfCategoryID:(NSString *)categoryID withBlock:(void (^)(NSArray *multiAttributes, NSError *error))block;
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"comm_list" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginNameAndCompanyName:@{@"categorytype" : @"2", @"categoryid" : categoryID}];//categorytype==2代表logo商店
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
	[self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
		if (block) {
			block(multiAttributes, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) {
			block(nil, error);
		}
	}];
}

- (void)goodsPropertiesWithBlock:(void (^)(NSArray *multiAttributes, NSError *error))block
{
	static NSArray *_multiAttributes;
	if (_multiAttributes) {
		if (block) {
			block(_multiAttributes, nil);
			return;
		}
		return;
	}
	NSDictionary *normalParameters = @{kAPIKeyAction : @"commproperty_list" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
	[self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
		_multiAttributes = multiAttributes;
		if (block) {
			block(multiAttributes, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) {
			block(nil, error);
		}
	}];
}

- (void)amountsOfGoods:(NSString *)goodsID withBlock:(void (^)(NSArray *multiAttributes, NSError *error))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"commpropertystock" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"commodityid" : goodsID}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
	[self postPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		id jsonValue = [self jsonValue:responseObject];
		NSArray *multiAttributes = jsonValue[@"retobj"];
		if (block) {
			block(multiAttributes, nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) {
			block(nil, error);
		}
	}];
}

- (void)submitOrder:(NSString *)orderDescribe withBlock:(void (^)(NSError *error))block
{
	NSDictionary *normalParameters = @{kAPIKeyAction : @"order_submit" , @"token" : [self getToken]};
	NSDictionary *jsonParameters = [self addLoginName:@{@"receiver" : @"", @"recadd" : @"", @"recphone" : @"", @"cartlist" : orderDescribe}];
	NSDictionary *parameters = [self normalParamters:normalParameters addJSONParameters:jsonParameters];
	
	[self getPath:kAPIInterface parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
		id jsonValue = [self jsonValue:responseObject];
		NSString *flag = [NSString stringWithFormat:@"%@", jsonValue[@"flag"]];
		NSError *error = nil;
		if (![flag isEqualToString:@"1"]) {
			NSString *message = jsonValue[@"msg"];
			error = [NSError errorWithDomain:DSH_ERROR_DOMAIN code:DSH_ERROR_CODE userInfo:@{DSH_ERROR_USERINFO_ERROR_MESSAGE : message}];
		}
		if (block) {
			block(nil);
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (block) {
			block(error);
		}
	}];
}

#pragma mark - utilities

- (NSString *)createJsonStringWithParam:(NSDictionary *)param
{
    NSArray *keys = [param allKeys];
    NSMutableString *json = [@"{" mutableCopy];
    for (int i = 0; i < keys.count; i ++) {
        NSString *keyValue = [NSString stringWithFormat:@"\"%@\":\"%@\"", keys[i], param[keys[i]]];
        [json appendString:keyValue];
        if ((i + 1) != keys.count) {
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

- (NSDictionary *)addLoginName:(NSDictionary *)parameters
{
	NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
	newParameters[@"loginname"] = [self userName];
	return newParameters;
}

- (NSDictionary *)addCompanyName:(NSDictionary *)parameters
{
	NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
	newParameters[@"company"] = [self companyName];
	return newParameters;
}

- (NSDictionary *)addLoginNameAndCompanyName:(NSDictionary *)parameters
{
	return [self addCompanyName:[self addLoginName:parameters]];
}

- (NSDictionary *)normalParamters:(NSDictionary *)parameters addJSONParameters:(NSDictionary *)JSONParamters
{
	NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
	newParameters[@"json"] = [self createJsonStringWithParam:JSONParamters];
	return newParameters;
}

@end

