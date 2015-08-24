//
//  Destination.m
//  EndOfTrip
//
//  Created by Charles He on 6/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//
#import "GlobalVariable.h"
#import "TimeViewController.h"
#import "Destination.h"
#import "APTEncription.h"

@interface Destination (){
    NSURLConnection *connection;
    NSMutableData *jsonData;
    NSMutableArray *lineNameArray;
    NSMutableArray *allDataDictionary;
}
@end

@implementation Destination

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Destination";

    // Do any additional setup after loading the view.
    NSString *urlString = [NSString stringWithFormat:@"http://timetableapi.ptv.vic.gov.au/v2/mode/0/line/%@/stops-for-line",_lineNumberString];
    NSURL *url=[APTEncription generateURLWithDevIDAndKey:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        if (jsonData==NULL) {
            jsonData=[[NSMutableData alloc]init];
        }
    }
    
    lineNameArray = [[NSMutableArray alloc]init];
    
    _destinationTable.delegate = self;
    _destinationTable.dataSource = self;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cell";
    
    UITableViewCell *cell=(UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text=[lineNameArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return lineNameArray.count;
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
    for(int i = 0 ; i< allDataDictionary.count ; i++){
        NSDictionary *currentIndex = [allDataDictionary objectAtIndex:i];
        NSString *currentLineName = [currentIndex objectForKey:@"location_name"];
        [lineNameArray addObject:currentLineName];
    }
    [_destinationTable reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSIndexPath *index = [_destinationTable indexPathForSelectedRow];
    NSDictionary *dataDictionary = [allDataDictionary objectAtIndex:index.row];
    GlobalVariable *obc = [GlobalVariable sharedInstance];
    obc.DESTINATION_STOP_STRING = [dataDictionary objectForKey:@"location_name"];
}

@end
