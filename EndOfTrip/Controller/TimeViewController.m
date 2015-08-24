//
//  TimeViewController.m
//  EndOfTrip
//
//  Created by Charles He on 23/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import "TimeViewController.h"
#import "APTEncription.h"
#import "GlobalVariable.h"

@interface TimeViewController(){
    NSURLConnection *connection;
    NSMutableData *jsonData;
    NSMutableArray *timeArray;
}

@end


@implementation TimeViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Select Departure Time";
    GlobalVariable *obc = [GlobalVariable sharedInstance];
    NSString *urlString = [NSString stringWithFormat:@"http://timetableapi.ptv.vic.gov.au/v2/mode/%@/line/%@/stop/%@/directionid/0/departures/all/limit/10",obc.TRANSPORT_TYPE ,obc.LINE_ID_STRING, obc.STARTING_STOP_ID_STRING];
    NSURL *url=[APTEncription generateURLWithDevIDAndKey:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        if (jsonData==NULL) {
            jsonData=[[NSMutableData alloc]init];
        }
    }
    
    timeArray = [[NSMutableArray alloc]init];
    
    _timeTable.delegate = self;
    _timeTable.dataSource = self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cell";
    
    UITableViewCell *cell=(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[timeArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return timeArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [jsonData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [jsonData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error:Failed with connection error.");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSMutableArray *valueArray = [allDataDictionary objectForKey:@"values"];
    for(int i = 0 ; i< valueArray.count ; i++){
        NSDictionary *currentIndex = [valueArray objectAtIndex:i];
        NSString *currentUTCTime = [currentIndex objectForKey:@"time_timetable_utc"];
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        NSTimeZone *inputTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        [fmt setTimeZone:inputTimeZone];
        [fmt setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        NSDate *date = [fmt dateFromString:currentUTCTime];
        NSTimeZone *outPutTimeZone = [NSTimeZone localTimeZone];
        NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc]init];
        [outPutFormatter setTimeZone:outPutTimeZone];
        [outPutFormatter setDateFormat:@"HH:mm"];
        NSString *outPutTimeString = [outPutFormatter stringFromDate:date];
        
        [timeArray addObject:outPutTimeString];
    }
    
    
    [_timeTable reloadData];
}


@end
