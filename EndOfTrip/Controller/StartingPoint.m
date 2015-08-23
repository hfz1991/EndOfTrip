//
//  StartingPoint.m
//  EndOfTrip
//
//  Created by Charles He on 6/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import "StartingPoint.h"
#import "APTEncription.h"
#import "Destination.h"

@interface StartingPoint (){
    NSURLConnection *connection;
    NSMutableData *jsonData;
    NSMutableArray *lineNameArray;
}
@end

@implementation StartingPoint

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Select Start Point";

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
    
    _startingTable.delegate = self;
    _startingTable.dataSource = self;
    
    
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
    NSMutableArray *allDataDictionary=[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    for(int i = 0 ; i< allDataDictionary.count ; i++){
        NSDictionary *currentIndex = [allDataDictionary objectAtIndex:i];
        NSString *currentLineName = [currentIndex objectForKey:@"location_name"];
        [lineNameArray addObject:currentLineName];
    }
    [_startingTable reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Destination *vc = [segue destinationViewController];
    //    NSLog(@"Selected #%ld",(long)index.row);
    vc.lineNumberString = _lineNumberString;
}

@end
