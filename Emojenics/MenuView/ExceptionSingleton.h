//
//  ExceptionSingleton.h
//  Elagoon's Kitchen
//
//  Created by Elagoon 1 on 13/07/17.
//  Copyright © 2017 Technical. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ExceptionSingleton : NSObject
{
   NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

+(NSString *)messageForException:(NSException *)exception;

@end
