//
//  Destination.h
//  EndOfTrip
//
//  Created by Charles He on 6/08/2015.
//  Copyright (c) 2015 Charles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Destination : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property NSString *lineNumberString;
@property (strong, nonatomic) IBOutlet UITableView *destinationTable;

@end
