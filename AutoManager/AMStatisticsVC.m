//
//  AMStatisticsVC.m
//  AutoManager
//
//  Created by Artem Mihajlov on 27.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMStatisticsVC.h"
#import "JBChartView/JBChartView.h"
#import "JBBarChartView.h"
#import "JBLineChartView.h"
#import "AMManualView.h"
#import "MCPieChartView.h"

#import "AMMaterialInput.h"
#import "AMFuelInput.h"
#import "AMWashInput.h"
#import "AMTOInput.h"
#import <MagicalRecord/MagicalRecord.h>
#import "AMFuelStatisticsView.h"
#import "AMKmStatisticsView.h"

@interface AMStatisticsVC () <MCPieChartViewDelegate, MCPieChartViewDataSource>

@property (strong, nonatomic) NSNumber * totalCost;
@property (strong, nonatomic) NSNumber * fuelCost;
@property (strong, nonatomic) NSNumber * materialCost;
@property (strong, nonatomic) NSNumber * toCost;
@property (strong, nonatomic) NSNumber * washCost;

@property (strong, nonatomic) NSNumber * fuelVolume;

@end

@implementation AMStatisticsVC

- (void)viewDidLoad {

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
- (IBAction)costDiagram:(id)sender {
    
    self.washCost = [AMWashInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:nil];
    self.fuelCost = [AMFuelInput MR_aggregateOperation:@"sum:" onAttribute:@"fuelCost" withPredicate:nil];
    self.materialCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:nil];
    self.toCost = [AMTOInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:nil];
    
    self.totalCost = [NSNumber numberWithFloat:[self.washCost floatValue] + [self.fuelCost floatValue] + [self.materialCost floatValue] + [self.toCost floatValue]];
    
    AMManualView * view = [[[NSBundle mainBundle] loadNibNamed:@"AMManualView"
                                                         owner:self
                                                       options:nil] firstObject];
    [view.from setHidden:YES];
    [self.view addSubview:view];
    
    UILabel *totalCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 320, 20)];
    totalCostLabel.text = [NSString stringWithFormat:@"Общая сумма трат - %.2f руб.", [self.totalCost floatValue]];
    [view addSubview:totalCostLabel];
    
    
    MCPieChartView *pieChart = [[MCPieChartView alloc] initWithFrame:CGRectMake(10, 50, 355, 400)];
    pieChart.delegate = self;
    pieChart.dataSource = self;
    pieChart.tag = 1;
    [view addSubview:pieChart];
    UIView * legendView = [[[NSBundle mainBundle] loadNibNamed:@"TotalCostLegendView"
                                                         owner:self
                                                       options:nil] firstObject];
    legendView.frame = CGRectMake(0, 450, 375, 150);
    [view addSubview:legendView];
}

- (IBAction)fuelStatistics:(id)sender {

    AMFuelStatisticsView * view = [[[NSBundle mainBundle] loadNibNamed:@"AMFuelStatisticsView"
                                                         owner:self
                                                       options:nil] firstObject];
    
    self.fuelVolume = [AMFuelInput MR_aggregateOperation:@"sum:" onAttribute:@"fuelVolume" withPredicate:nil];
    
    NSArray *fuel92 = [AMFuelInput MR_findByAttribute:@"fuelType" withValue:@"Бензин АИ-92"];
    NSArray *fuel95 = [AMFuelInput MR_findByAttribute:@"fuelType" withValue:@"Бензин АИ-95"];
    NSArray *fuel98 = [AMFuelInput MR_findByAttribute:@"fuelType" withValue:@"Бензин АИ-98"];
    NSArray *fuelGas = [AMFuelInput MR_findByAttribute:@"fuelType" withValue:@"Газ"];
    
    NSInteger maxCount = MAX(MAX(MAX(fuel92.count, fuel95.count), fuel98.count), fuelGas.count);
    
    view.fuelOverall.text = [NSString stringWithFormat:@"%.1f л.", [self.fuelVolume floatValue]];
    
    if (fuel92.count == maxCount) view.preferedFuel.text = @"Бензин АИ-92";
    if (fuel95.count == maxCount) view.preferedFuel.text = @"Бензин АИ-95";
    if (fuel98.count == maxCount) view.preferedFuel.text = @"Бензин АИ-98";
    if (fuelGas.count == maxCount) view.preferedFuel.text = @"Газ";
    
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *minDateComp = [calendar components:( NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay ) fromDate:[AMFuelInput MR_aggregateOperation:@"min:" onAttribute:@"date" withPredicate:nil]];
    NSDateComponents *maxDateComp = [calendar components:( NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay ) fromDate:[AMFuelInput MR_aggregateOperation:@"max:" onAttribute:@"date" withPredicate:nil]];
    
    NSInteger months =(([maxDateComp year] - [minDateComp year]) * 12 + [maxDateComp month] - [minDateComp month]);
    if (months == 0) {
        months = 1;
    }
    
    view.fuelAtMonth.text = [NSString stringWithFormat:@"%.1f л./мес", [self.fuelVolume floatValue] / months];
    
    NSNumber * minKm = [AMFuelInput MR_aggregateOperation:@"min:" onAttribute:@"km" withPredicate:nil];
    NSNumber * maxKm = [AMFuelInput MR_aggregateOperation:@"max:" onAttribute:@"km" withPredicate:nil];
    
    view.fuelToKm.text = [NSString stringWithFormat:@"%.1f л.", [self.fuelVolume floatValue] / ([maxKm floatValue] - [minKm floatValue])];
    
    self.fuelCost = [AMFuelInput MR_aggregateOperation:@"sum:" onAttribute:@"fuelCost" withPredicate:nil];
    NSUInteger count = [AMFuelInput MR_countOfEntities];
    
    view.averageCost.text = [NSString stringWithFormat:@"%.2f руб.", [self.fuelCost floatValue] / count];
    
    
    [self.view addSubview:view];
}

- (IBAction)kmStatistics:(id)sender {
    
    AMKmStatisticsView * view = [[[NSBundle mainBundle] loadNibNamed:@"AMKmStatisticsView"
                                                                 owner:self
                                                               options:nil] firstObject];

     NSInteger maxKmFuel = [[AMFuelInput MR_aggregateOperation:@"max:" onAttribute:@"km" withPredicate:nil] integerValue];
    NSInteger maxKmMaterials = [[AMMaterialInput MR_aggregateOperation:@"max:" onAttribute:@"km" withPredicate:nil] integerValue];
    NSInteger maxKmWash = [[AMWashInput MR_aggregateOperation:@"max:" onAttribute:@"km" withPredicate:nil] integerValue];
    NSInteger maxKmTo = [[AMTOInput MR_aggregateOperation:@"max:" onAttribute:@"km" withPredicate:nil] integerValue];
    
    NSInteger maxKm = MAX(MAX(MAX(maxKmFuel, maxKmTo), maxKmWash), maxKmMaterials);
    
    view.overallKm.text = [NSString stringWithFormat:@"%li км", (long)maxKm];
    
    NSInteger minKmFuel = [[AMFuelInput MR_aggregateOperation:@"min:" onAttribute:@"km" withPredicate:nil] integerValue];
    NSInteger minKmMaterials = [[AMMaterialInput MR_aggregateOperation:@"min:" onAttribute:@"km" withPredicate:nil] integerValue];
    NSInteger minKmWash = [[AMWashInput MR_aggregateOperation:@"min:" onAttribute:@"km" withPredicate:nil] integerValue];
    NSInteger minKmTo = [[AMTOInput MR_aggregateOperation:@"min:" onAttribute:@"km" withPredicate:nil] integerValue];
    
    NSInteger minKm = MIN(MIN(MIN(minKmFuel, minKmTo), minKmWash), minKmMaterials);
    
    NSDate *minDate;
    NSDate *maxDate;
    
    if ([AMFuelInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]])
        minDate = [AMFuelInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]].date;
    if ([AMTOInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]])
        minDate = [AMTOInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]].date;
    if ([AMMaterialInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]])
        minDate = [AMMaterialInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]].date;
    if ([AMWashInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]])
        minDate = [AMWashInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:minKm]].date;
    
    if ([AMFuelInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]])
        maxDate = [AMFuelInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]].date;
    if ([AMWashInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]])
        maxDate = [AMWashInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]].date;
    if ([AMMaterialInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]])
        maxDate = [AMMaterialInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]].date;
    if ([AMTOInput MR_findByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]])
        maxDate = [AMTOInput MR_findFirstByAttribute:@"km" withValue:[NSNumber numberWithInteger:maxKm]].date;
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *minDateComp = [calendar components:( NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay ) fromDate:minDate];
    NSDateComponents *maxDateComp = [calendar components:( NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay ) fromDate:maxDate];
    
    NSInteger months =(([maxDateComp year] - [minDateComp year]) * 12 + ([maxDateComp month] - [minDateComp month]));
    if (months == 0) {
        months = 1;
    }
    NSInteger days = (([maxDateComp year] - [minDateComp year]) * 365 + ([maxDateComp month] - [minDateComp month])*30 + [maxDateComp day] - [minDateComp day]);
    if (days == 0) {
        days = 1;
    }
    
    view.KmPerDay.text = [NSString stringWithFormat:@"%.1ld км", (maxKm - minKm) / days];
    view.KmPerMonth.text = [NSString stringWithFormat:@"%.1ld км", (maxKm - minKm) / months];
    [self.view addSubview:view];
}

- (IBAction)materialsStatistics:(id)sender {
    
    AMManualView * view = [[[NSBundle mainBundle] loadNibNamed:@"AMManualView"
                                                         owner:self
                                                       options:nil] firstObject];
    [view.from setHidden:YES];
    [self.view addSubview:view];
    NSNumber * totalCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:nil];
    UILabel *totalCostLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 320, 60)];
    totalCostLabel.text = [NSString stringWithFormat:@"Всего потрачено на ремонт и комплектующие - %.2f руб.", [totalCost floatValue]];
//    totalCostLabel.backgroundColor = [UIColor blueColor];
    totalCostLabel.contentMode = UIViewContentModeTopLeft;
    totalCostLabel.numberOfLines = 0;
    [view addSubview:totalCostLabel];

    
    MCPieChartView *pieChart = [[MCPieChartView alloc] initWithFrame:CGRectMake(10, 70, 355, 400)];
    pieChart.delegate = self;
    pieChart.dataSource = self;
    pieChart.tag = 2;
    [view addSubview:pieChart];
    UIView * legendView = [[[NSBundle mainBundle] loadNibNamed:@"AMMaterialLegendView"
                                                         owner:self
                                                       options:nil] firstObject];
    legendView.frame = CGRectMake(0, 450, 375, 150);
    [view addSubview:legendView];
}




-(NSInteger)numberOfSlicesInPieChartView:(MCPieChartView *)pieChartView {
    return 4;
}

-(UIColor *)pieChartView:(MCPieChartView *)pieChartView colorForSliceAtIndex:(NSInteger)index {
    if (index == 0) return [UIColor blueColor];
    if (index == 1) return [UIColor redColor];
    if (index == 2) return [UIColor yellowColor];
    return [UIColor greenColor];
}
//метод делегата класса диаграммы, обрабатыватывющий текст каждого сегмента диаграммы
-(NSString *)pieChartView:(MCPieChartView *)pieChartView textForSliceAtIndex:(NSInteger)index {
    //диграмма с тэгом 1 - диаграмма всех расходов на автомобиль
    if (pieChartView.tag == 1) {
        if (index == 0) return [NSString stringWithFormat:@"%i%%", (int)(([self.materialCost floatValue] / [self.totalCost floatValue])*100)];
        if (index == 1) return [NSString stringWithFormat:@"%i%%", (int)(([self.fuelCost floatValue] / [self.totalCost floatValue])*100)];
        if (index == 2) return [NSString stringWithFormat:@"%i%%", (int)(([self.toCost floatValue] / [self.totalCost floatValue])*100)];
        return [NSString stringWithFormat:@"%i%%", (int)(([self.washCost floatValue] / [self.totalCost floatValue])*100)];
    }
    //диаграмма с тэгом 2 - диаграмма расходов из категории "Ремонт и комплектующие"
    else {
        NSNumber * totalCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:nil];
        NSNumber *matCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Расходные материалы'"]];
        NSNumber *remCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Ремонт'"]];
        NSNumber *styleCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Внешний вид'"]];
        NSNumber *repCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Запчасти'"]];
        
        if (index == 0) return [NSString stringWithFormat:@"%i%%", (int)(([matCost floatValue] / [totalCost floatValue])*100)];
        if (index == 1) return [NSString stringWithFormat:@"%i%%", (int)(([repCost floatValue] / [totalCost floatValue])*100)];
        if (index == 2) return [NSString stringWithFormat:@"%i%%", (int)(([remCost floatValue] / [totalCost floatValue])*100)];
        return [NSString stringWithFormat:@"%i%%", (int)(([styleCost floatValue] / [totalCost floatValue])*100)];
    }
}
//метод делегата класса диаграммы, обрабатыватывющий значение каждого сегмента диаграммы
-(CGFloat)pieChartView:(MCPieChartView *)pieChartView valueForSliceAtIndex:(NSInteger)index {
    if (pieChartView.tag == 1) {
        if (index == 0) return [self.materialCost floatValue];
        if (index == 1) return [self.fuelCost floatValue];
        if (index == 2) return [self.toCost floatValue];
        return [self.washCost floatValue];
    } else {
        NSNumber *matCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Расходные материалы'"]];
        NSNumber *remCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Ремонт'"]];
        NSNumber *styleCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Внешний вид'"]];
        NSNumber *repCost = [AMMaterialInput MR_aggregateOperation:@"sum:" onAttribute:@"cost" withPredicate:[NSPredicate predicateWithFormat:@"type == 'Запчасти'"]];
        
            if (index == 0) return [matCost floatValue];
            if (index == 1) return [repCost floatValue];
            if (index == 2) return [remCost floatValue];
            return [styleCost floatValue];
    }
}

@end
