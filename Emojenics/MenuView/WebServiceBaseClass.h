//
//  WebServiceBaseClass.h
//  Game Day
//
//  Created by Elagoon.
//  Copyright © 2017 Elagoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServiceConstant.h"


@interface WebServiceBaseClass : NSObject


+(void)CallGet:(NSString *)serviceUrl Param:(NSDictionary *)params Completion:(void(^)(BOOL isSucceed, NSDictionary *response))completion;
+(void)CallPost:(NSString *)serviceUrl Param:(NSDictionary *)params Completion:(void(^)(BOOL isSucceed, NSDictionary *response))completion;



@end


