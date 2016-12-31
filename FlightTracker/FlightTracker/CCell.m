//
//  CCell.m
//  FlightTracker
//
//  Created by Suvayan Roy on 12/30/16.
//  Copyright © 2016 Suvayan Roy. All rights reserved.
//
#import "CCell.h"
#import <Foundation/Foundation.h>
#include <UIKit/UIKit.h>



@implementation CCell
@synthesize label2;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
