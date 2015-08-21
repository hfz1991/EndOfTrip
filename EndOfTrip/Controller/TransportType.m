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
    GlobalVariable *obc = [GlobalVariable sharedInstance];
    obc.TRANSPORT_TYPE = [NSNumber numberWithInt:0];
}

- (IBAction)tramButton:(id)sender {
    GlobalVariable *obc = [GlobalVariable sharedInstance];
    obc.TRANSPORT_TYPE = [NSNumber numberWithInt:1];
    NSLog(@"%@",obc.TRANSPORT_TYPE);
}

- (IBAction)trainButton:(id)sender {
    GlobalVariable *obc = [GlobalVariable sharedInstance];
    obc.TRANSPORT_TYPE = [NSNumber numberWithInt:2];
}
@end
