//
//  JourneyTableViewCell.h
//  EndOfTrip
//
//  Created by Charles He on 25/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JourneyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stopLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
