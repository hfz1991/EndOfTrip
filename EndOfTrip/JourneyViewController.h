//
//  JourneyViewController.h
//  EndOfTrip
//
//  Created by Charles He on 25/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JourneyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *startingStopLabel;
@property (weak, nonatomic) IBOutlet UILabel *TransportTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationStopLabel;
@property (weak, nonatomic) IBOutlet UITableView *journeyTable;

@end
