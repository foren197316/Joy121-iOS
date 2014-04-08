//
//  JUser.h
//  Joy
//
//  Created by 颜超 on 14-4-7.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

//flag = 1;
//msg = "<null>";
//retobj =     {
//    BirthDay = "/Date(315936000000+0800)/";
//    CellNumber = 18662652121;
//    ClaimPrint = "<null>";
//    Company = "DELPHI_SZ";
//    CompanyInfo = "<null>";
//    CompanyName = "\U5fb7\U5c14\U798f\U7535\U5b50\Uff08\U82cf\U5dde\Uff09\U6709\U9650\U516c\U53f8";
//    CreateTime = "/Date(1303439971000+0800)/";
//    EmployeeId = "<null>";
//    EndInsured = "/Date(-62135596800000+0800)/";
//    ExpiredTime = "/Date(-62135596800000+0800)/";
//    Flag = 1;
//    Gender = 0;
//    IdNo = 320511198001062561;
//    InsCompanyNO = "<null>";
//    IsManager = 1;
//    IsQuitUser = 0;
//    LastLoginTime = "/Date(1396710348000+0800)/";
//    LoginName = steven;
//    LoginPasswd = 4c56ff4ce4aaf9573aa5dff913df997a;
//    Mail = "steven@joy121.com";
//    PhoneNumber = "0512-88852121";
//    Points = 380;
//    StartInsured = "/Date(-62135596800000+0800)/";
//    UserCompanyBenefittype = "<null>";
//    UserName = "\U5218\U60f3\U67f1";
//    UserPortalMenus = "<null>";
//    }
#import <Foundation/Foundation.h>

@interface JUser : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *birthDay;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *reDate;  //注册日期
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *cardNo; //身份证
@property (nonatomic, strong) NSString *companyName;

+ (JUser *)createJUserWithDict:(NSDictionary *)dict;
@end

