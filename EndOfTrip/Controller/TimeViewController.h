//
//  TimeViewController.h
//  EndOfTrip
//
//  Created by Charles He on 23/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *timeTable;

@end
