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
    NSNumber *_STARTING_STOP_ID;
    NSNumber *_TRANSPORT_TYPE;
}

+ (GlobalVariable *)sharedInstance;

@property (nonatomic, strong) NSNumber *TRANSPORT_TYPE;
@property (nonatomic, strong) NSNumber *STARTING_STOP_ID;


@end