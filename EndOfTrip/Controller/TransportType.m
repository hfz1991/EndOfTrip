//
//  TransportType.m
//  EndOfTrip
//
//  Created by Charles He on 6/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//
#import "GlobalVariable.h"
#import "TransportType.h"

@implementation TransportType

- (IBAction)busButton:(id)sender {
    TRANSPORT_TYPE = 0;
}

- (IBAction)tramButton:(id)sender {
    TRANSPORT_TYPE = 1;
}

- (IBAction)trainButton:(id)sender {
    TRANSPORT_TYPE = 2;
}
@end
