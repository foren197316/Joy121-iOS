//
//  ScoreInfo.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//{
//    Action = 1;
//    ActionTime = "/Date(1356969600000+0800)/";
//    COMPNAME = "\U865a\U62df\U516c\U53f8";
//    Company = YEY;
//    IDNo = "<null>";
//    LoginName = steven;
//    Points = 200;
//    Remark = "2013\U5e74\U5458\U5de5\U751f\U65e5\U798f\U5229";
//    UserName = "<null>";
//}
@interface ScoreInfo : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *mark;
+ (ScoreInfo *)createScoreInfoWithDict:(NSDictionary *)dict;
+ (NSArray *)createScoreInfosWithArray:(NSArray *)array;
@end
