//
//  PayRoll.m
//  Joy
//
//  Created by summer on 11/18/14.
//  Copyright (c) 2014 颜超. All rights reserved.
//

#import "PayRoll.h"

@implementation PayRoll

-(instancetype) initWithAttributes:(NSDictionary *)attributes
{
   self = [super initWithAttributes:attributes];
    if (self){
        _id=attributes[@"id"];
        _payablepay=attributes[@"payablepay"];
        _realwagwages=attributes[@"realwagwages"];
        _subsidysum=attributes[@"subsudysum"];
        _sequestrate=attributes[@"sequestrate"];
        
    }
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"< id: %@, payablepay: %@>",_id,_payablepay];
}

@end
