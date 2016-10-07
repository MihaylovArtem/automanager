//
//  AMFuelStatisticsView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 28.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMFuelStatisticsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *fuelOverall;
@property (weak, nonatomic) IBOutlet UILabel *fuelAtMonth;
@property (weak, nonatomic) IBOutlet UILabel *preferedFuel;
@property (weak, nonatomic) IBOutlet UILabel *fuelToKm;
@property (weak, nonatomic) IBOutlet UILabel *averageCost;

@end
