//
//  AMUserSettings.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMUserSettings.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMUserSettings

+(instancetype) initWithDocDate:(NSDate *)docDate mark:(NSString*)mark Model:(NSString*)model andCarDate:(NSDate*)carDate {
    
    __block AMUserSettings * userSettings;
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        userSettings = [AMUserSettings MR_findFirstInContext:localContext];
        if (!userSettings) {
            userSettings = [AMUserSettings MR_createEntityInContext:localContext];
        }
        userSettings.docDate = docDate;
        userSettings.model = model;
        userSettings.mark = mark;
        userSettings.carDate = carDate;
    }];
    
    return [userSettings MR_inContext:[NSManagedObjectContext MR_defaultContext]];
}

@end
