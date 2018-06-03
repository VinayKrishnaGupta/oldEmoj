//
//  ExceptionSingleton.m
//  Elagoon's Kitchen
//
//  Created by Elagoon 1 on 13/07/17.
//  Copyright © 2017 Technical. All rights reserved.
//

#import "ExceptionSingleton.h"

@implementation ExceptionSingleton
 @synthesize someProperty;

#pragma mark -

+ (id)sharedManager {
    static ExceptionSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

+(NSString *)messageForException:(NSException *)exception  {
    NSString *message;
    if([exception.name isEqualToString:NSPortTimeoutException] || [exception.name isEqualToString:NSInvalidReceivePortException] ||[exception.name isEqualToString:NSInvalidSendPortException]||[exception.name isEqualToString:NSPortSendException]||[exception.name isEqualToString:NSPortReceiveException])
    {
        
        
       message=@"Network error...";
        
    }
    return message;
}

@end
