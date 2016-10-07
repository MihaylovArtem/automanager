//
//  AMKmStatisticsView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 29.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMKmStatisticsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *overallKm;
@property (weak, nonatomic) IBOutlet UILabel *KmPerMonth;
@property (weak, nonatomic) IBOutlet UILabel *KmPerDay;

@end
