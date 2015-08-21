//
//  GlobalVariable.m
//  EndOfTrip
//
//  Created by Charles He on 28/07/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalVariable.h"

@interface GlobalVariable ()

@end

@implementation GlobalVariable
@synthesize testString = _testString;
@synthesize TRANSPORT_TYPE = _TRANSPORT_TYPE;

+ (GlobalVariable *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVariable *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVariable alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _testString = nil;
        _TRANSPORT_TYPE = nil;
    }
    return self;
}

@end




