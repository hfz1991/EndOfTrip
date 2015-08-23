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
@synthesize TRANSPORT_TYPE = _TRANSPORT_TYPE;
@synthesize LINE_ID_STRING = _LINE_ID_STRING;
@synthesize STARTING_STOP_ID_STRING = _STARTING_STOP_ID_STRING;

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
        _TRANSPORT_TYPE = nil;
        _LINE_ID_STRING = nil;
        _STARTING_STOP_ID_STRING = nil;
    }
    return self;
}

@end




