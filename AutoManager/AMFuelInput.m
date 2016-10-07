//
//  AMFuelInput.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMFuelInput.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMFuelInput

+(instancetype) initWithType:(NSString *)type volume:(NSNumber*)volume Km:(NSNumber*)km andCost:(NSNumber*)cost {
    
    __block AMFuelInput * fuelInput;
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        fuelInput = [AMFuelInput MR_createEntityInContext:localContext];
        fuelInput.fuelType = type;
        fuelInput.fuelVolume = volume;
        fuelInput.fuelCost = cost;
        fuelInput.date = [NSDate date];
        fuelInput.km = km;
    }];
    
    return [fuelInput MR_inContext:[NSManagedObjectContext MR_defaultContext]];
}

@end
