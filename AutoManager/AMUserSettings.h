//
//  AMUserSettings.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMUserSettings : NSManagedObject

+(instancetype) initWithDocDate:(NSDate *)docDate mark:(NSString*)mark Model:(NSString*)model andCarDate:(NSDate*)carDate;
//+(instancetype) configureWithDocDate:(NSDate *)docDate mark:(NSString*)mark Model:(NSString*)model andCarDate:(NSDate*)carDate;

@end

NS_ASSUME_NONNULL_END

#import "AMUserSettings+CoreDataProperties.h"
