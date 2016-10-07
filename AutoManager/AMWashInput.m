//
//  AMWashInput.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMWashInput.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMWashInput

+(instancetype)initWithKm:(NSNumber *)km andCost:(NSNumber *)cost {
    __block AMWashInput * input;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        input = [AMWashInput MR_createEntityInContext:localContext];
        
        input.km = km;
        input.date = [NSDate date];
        input.cost = cost;
    }];
    
    return [input MR_inContext:[NSManagedObjectContext MR_defaultContext]];
}

@end
