//
//  DetailViewController.h
//  FlightTracker
//
//  Created by Suvayan Roy on 12/30/16.
//  Copyright © 2016 Suvayan Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

