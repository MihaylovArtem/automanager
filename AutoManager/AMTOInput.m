//
//  AMTOInput.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMTOInput.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMTOInput

+(instancetype) initWithKm:(NSNumber*)km Cost:(NSNumber*)cost andDate:(NSDate *)date {
    __block AMTOInput * input;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        input = [AMTOInput MR_findFirstInContext:localContext];
        if (!input) {
            input = [AMTOInput MR_createEntityInContext:localContext];
        }
        input.km = km;
        input.date = date;
        input.cost = cost;
    }];
    
    return [input MR_inContext:[NSManagedObjectContext MR_defaultContext]];
}
@end
