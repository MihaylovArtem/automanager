//
//  AMExtreme.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMExtreme.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation AMExtreme

+(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    AMExtreme * manual = [AMExtreme MR_createEntity];
    manual.desc = dictionary[@"desc"];
    manual.image = dictionary[@"image"]? dictionary[@"image"] : @"";
    manual.from = dictionary[@"from"];
    
    return manual;
}

@end
