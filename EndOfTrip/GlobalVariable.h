//
//  GlobalVariable.h
//  EndOfTrip
//
//  Created by Charles He on 28/07/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#include <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@class GlobalVariable;

@interface GlobalVariable : NSObject{
    NSNumber *_TRANSPORT_TYPE;
    NSString *_LINE_ID_STRING;
    NSString *_STARTING_STOP_ID_STRING;
    NSString *_STARTING_STOP_STRING;
    NSString *_DESTINATION_STOP_STRING;
}

+ (GlobalVariable *)sharedInstance;

@property (nonatomic, strong) NSNumber *TRANSPORT_TYPE;
@property (nonatomic, strong) NSString *STARTING_STOP_ID_STRING;
@property (nonatomic, strong) NSString *STARTING_STOP_STRING;
@property (nonatomic, strong) NSString *LINE_ID_STRING;
@property (nonatomic, strong) NSString *DESTINATION_STOP_STRING;

@end