//
//  AMManual.m
//  AutoManager
//
//  Created by Artem Mihajlov on 24.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMManual.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMManual

// Insert code here to add functionality to your managed object subclass

+(instancetype) initWithDictionary:(NSDictionary *)dictionary {
    AMManual * manual = [AMManual MR_findFirstByAttribute:@"name" withValue:dictionary[@"name"]];
    if (!manual) {
        manual = [AMManual MR_createEntity];
    }
    manual.desc = dictionary[@"desc"];
    manual.name = dictionary[@"name"];
    manual.image = dictionary[@"image"]? dictionary[@"image"] : @"";
    manual.from = dictionary[@"from"];
    
    return manual;
}

@end
