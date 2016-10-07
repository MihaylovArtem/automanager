//
//  AMMaterialInput.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMMaterialInput.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMMaterialInput

+(instancetype) initWithKm:(NSNumber*)km Cost:(NSNumber*)cost andType:(NSString *)type {
    __block AMMaterialInput * input;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        input = [AMMaterialInput MR_createEntityInContext:localContext];
        input.km = km;
        input.type = type;
        input.cost = cost;
        input.date = [NSDate date];
    }];
    
    return [input MR_inContext:[NSManagedObjectContext MR_defaultContext]];
}

@end
