//
//  FirstScreenViewController.m
//  EndOfTrip
//
//  Created by Charles He on 27/07/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import "FirstScreenViewController.h"
#import "APTEncription.h"
@interface FirstScreenViewController ()

@end

@implementation FirstScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [APTEncription generateURLWithDevIDAndKey:@"http://timetableapi.ptv.vic.gov.au/v2/search/Route"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
