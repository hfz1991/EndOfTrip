//
//  APTEncription.m
//  EndOfTrip
//
//  Created by Charles He on 6/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//
#import "APTEncription.h"
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

@implementation APTEncription

+(NSURL*) generateURLWithDevIDAndKey:(NSString*)urlPath {
    
    NSString *hardcodedURL = @"http://timetableapi.ptv.vic.gov.au";
    NSString *hardcodedDevID = @"1000334";
    NSString *hardcodedkey = @"9ceb57bc-8a57-11e4-a34a-0665401b7368";
    
    NSRange deleteRange ={0,[hardcodedURL length]};
    NSMutableString *urlString = [[NSMutableString alloc]initWithString:urlPath];
    [urlString deleteCharactersInRange:deleteRange];
    if( [urlString containsString:@"?"])
        [urlString appendString:@"&"];
    else
        [urlString appendString:@"?"];
    [urlString appendFormat:@"devid=%@",hardcodedDevID];
    const char *cKey = [hardcodedkey cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [urlString cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSString *hash;
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    
    hash = output;
    
    NSString* signature = [hash uppercaseString];
    NSString *urlSuffix = [NSString stringWithFormat:@"devid=%@&signature=%@", hardcodedDevID,signature];
    NSURL *url = [NSURL URLWithString:urlPath]; NSString *urlQuery = [url query];
    if(urlQuery != nil && [urlQuery length] > 0){
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&%@",urlPath,urlSuffix]]; }else{
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",urlPath,urlSuffix]]; }
    
    NSLog(@"%@",url);
    return url;
}


@end
