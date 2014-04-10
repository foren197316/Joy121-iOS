//
//  WelInfo.h
//  Joy
//
//  Created by 颜超 on 14-4-9.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    AppDescription = "\U63cf\U8ff0\U5458\U5de5\U798f\U5229\U5957\U9910\U4e8c";
//    AppPicture = "appD002_1.jpg;appD002_2.jpg;appD002_3.jpg";
//    BuyPersons = "<null>";
//    CommSetOrderSx = 0;
//    Commodities = "<null>";
//    CreateTime = "/Date(1396336841000+0800)/";
//    Description = "\U672c\U5957\U9910\U56e0\U4e3a\U5546\U54c1\U7684\U65f6\U6548\U6027\U8f83\U5f3a\Uff0c\U6240\U4ee5\U8bf7\U4e8e\U89c4\U5b9a\U7684\U65f6\U95f4\U5185\U786e\U5b9a\U3002<br />\U5982\U679c\U4e0d\U60f3\U4f7f\U7528\U6539\U5957\U9910\Uff0c\U5458\U5de5\U53ef\U4ee5\U5c06\U79ef\U5206\U8f6c\U5316\U4e3a\U4e2a\U4eba\U79ef\U5206\Uff0c\U4e0e\U5176\U4ed6\U8282\U65e5\U79ef\U5206\U79ef\U7d2f\U4f7f\U7528\U3002<br />\U672c\U5957\U9910\U7edf\U4e00\U914d\U9001\Uff0c\U5177\U4f53\U65f6\U95f4\U53e6\U884c\U901a\U77e5\U3002";
//    EXPIREDDATE = "/Date(1398787200000+0800)/";
//    ExpireDate = "/Date(-62135596800000+0800)/"; 截止日期
//    Flag = 1;
//    Id = 22;
//    IsDefault = 0;
//    MarketPrice = 100;
//    Picture = "D002.png";
//    Points = 80;
//    SetName = "\U3010\U7aef\U5348\U8282\U3011\U5458\U5de5\U798f\U5229\U5957\U9910\U4e8c";
//    SetNo = D002;
//    SetType = 15;
//    StartDate = "/Date(1396281600000+0800)/";
//    TypeName = "\U7aef\U5348\U8282";
//}
//);
@interface WelInfo : NSObject

@property (nonatomic, strong) NSString *shortDescribe;
@property (nonatomic, strong) NSArray *picturesArray;
@property (nonatomic, strong) NSString *headPic;
@property (nonatomic, strong) NSString *wid;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *longDescribe;
@property (nonatomic, strong) NSString *welName;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

+ (WelInfo *)createWelInfoWithDictionary:(NSDictionary *)dict;
+ (NSArray *)createWelInfosWithArray:(NSArray *)arr;
@end
