//
//  OrderInfo.h
//  Joy
//
//  Created by 颜超 on 14-4-10.
//  Copyright (c) 2014年 颜超. All rights reserved.
//

#import <Foundation/Foundation.h>
//{
//    CommodityInfo = "21:2:1;";
//    Company = "<null>";
//    CreateTime = "/Date(1397113793000+0800)/";
//    Deliveryer = "";
//    ExpectDate = "/Date(-62135596800000+0800)/";
//    ExpectTime = 0;
//    Flag = 1;
//    IsBenefit = 0;
//    LocalFee = 0;
//    LoginName = steven;
//    LstCommodity =             (
//    );
//    LstCommoditySet =             (
//                                   {
//                                       AppDescription = "\U63cf\U8ff0\U5458\U5de5\U798f\U5229\U5957\U9910\U4e00";
//                                       AppPicture = "appD001_1.jpg;appD001_2.jpg;appD001_3.jpg";
//                                       BuyPersons = "<null>";
//                                       CommSetOrderSx = 0;
//                                       Commodities = "<null>";
//                                       CreateTime = "/Date(1396335928000+0800)/";
//                                       Description = "\U672c\U5957\U9910\U56e0\U4e3a\U5546\U54c1\U7684\U65f6\U6548\U6027\U8f83\U5f3a\Uff0c\U6240\U4ee5\U8bf7\U4e8e\U89c4\U5b9a\U7684\U65f6\U95f4\U5185\U786e\U5b9a\U3002<br />\U5982\U679c\U4e0d\U60f3\U4f7f\U7528\U6539\U5957\U9910\Uff0c\U5458\U5de5\U53ef\U4ee5\U5c06\U79ef\U5206\U8f6c\U5316\U4e3a\U4e2a\U4eba\U79ef\U5206\Uff0c\U4e0e\U5176\U4ed6\U8282\U65e5\U79ef\U5206\U79ef\U7d2f\U4f7f\U7528\U3002<br />\U672c\U5957\U9910\U7edf\U4e00\U914d\U9001\Uff0c\U5177\U4f53\U65f6\U95f4\U53e6\U884c\U901a\U77e5\U3002";
//                                       EXPIREDDATE = "/Date(-62135596800000+0800)/";
//                                       ExpireDate = "/Date(-62135596800000+0800)/";
//                                       Flag = 1;
//                                       Id = 21;
//                                       IsDefault = "<null>";
//                                       MarketPrice = 60;
//                                       Picture = "D001.png";
//                                       Points = 50;
//                                       SetName = "\U3010\U7aef\U5348\U8282\U3011\U5458\U5de5\U798f\U5229\U5957\U9910\U4e00";
//                                       SetNo = D001;
//                                       SetType = 15;
//                                       StartDate = "/Date(-62135596800000+0800)/";
//                                       TypeName = "\U7aef\U5348\U8282";
//                                   }
//                                   );
//    Operator = "<null>";
//    OrderId = 20140410030953197;
//    OrderProcessRemark = "<null>";
//    OrderSX = 0;
//    PaymentWay = "";
//    Points = 50;
//    ReceiveLocationId = 0;
//    ReceivePhone = 18662652121;
//    ReceiveTime = "/Date(253402271999000+0800)/";
//    Receiver = "\U5218\U60f3\U67f1";
//    ReceiverAddress = "\U5fb7\U5c14\U798f\U7535\U5b50\Uff08\U82cf\U5dde\Uff09\U6709\U9650\U516c\U53f8";
//    ReceiverAddressType = 0;
//    ReceiverId = 0;
//    Remark = "";
//    Satisfy = 0;
//    TimeFee = 0;
//},

@interface OrderInfo : NSObject

@property (nonatomic, strong) NSArray *welArrays; //WelInfo
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *orderNo;

+ (NSArray *)createOrderInfosWithArray:(NSArray *)arr;
+ (OrderInfo *)createOrderInfoWithDictionary:(NSDictionary *)dict;

@end
