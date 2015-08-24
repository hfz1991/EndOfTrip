//
//  JourneyViewController.m
//  EndOfTrip
//
//  Created by Charles He on 25/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import "JourneyViewController.h"
#import "APTEncription.h"
#import "GlobalVariable.h"

@interface JourneyViewController (){
    NSURLConnection *connection;
    NSMutableData *jsonData;
    NSMutableArray *stopArray;
    NSMutableArray *timeArray;
    NSDictionary *allDataDictionary;

}

@end

@implementation JourneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GlobalVariable *obc = [GlobalVariable sharedInstance];
    _destinationStopLabel.text = obc.DESTINATION_STOP_STRING;
    _startingStopLabel.text = obc.STARTING_STOP_STRING;
    _TransportTypeLabel.text = [self transportTypeTranslator:obc.TRANSPORT_TYPE];
    
    self.title = @"Your Journey";
    NSString *urlString = [NSString stringWithFormat:@"http://timetableapi.ptv.vic.gov.au/v2/mode/%@/run/%@/stop/%@/stopping-pattern",obc.TRANSPORT_TYPE ,obc.RUN_ID_STRING, obc.STARTING_STOP_ID_STRING];
    NSURL *url=[APTEncription generateURLWithDevIDAndKey:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        if (jsonData==NULL) {
            jsonData=[[NSMutableData alloc]init];
        }
    }
    
    stopArray = [[NSMutableArray alloc]init];
    timeArray = [[NSMutableArray alloc]init];
    
    _journeyTable.delegate = self;
    _journeyTable.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)transportTypeTranslator:(NSNumber *)transType{
    switch(transType.intValue){
        case 0:
            return @"Train";
        case 1:
            return @"Tram";
        case 2:
            return @"Bus";
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cell";
    
    UITableViewCell *cell=(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[stopArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return stopArray.count;
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
    allDataDictionary=[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSMutableArray *valueArray = [allDataDictionary objectForKey:@"values"];
    for(int i = 0 ; i< valueArray.count ; i++){
        NSDictionary *currentIndex = [valueArray objectAtIndex:i];
        NSString *currentUTCTime = [currentIndex objectForKey:@"time_timetable_utc"];
        //stop
        NSDictionary *platformDictionary = [currentIndex objectForKey:@"platform"];
        NSDictionary *stopDictionary = [platformDictionary objectForKey:@"stop"];
        NSString *currentStopString = [stopDictionary objectForKey:@"location_name"];
        
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
        [stopArray addObject:currentStopString];
    }
    
    
    [_journeyTable reloadData];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
