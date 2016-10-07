//
//  AMTOInput.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMTOInput : NSManagedObject

+(instancetype)initWithKm:(NSNumber*)km Cost:(NSNumber*)cost andDate:(NSDate*)date;

@end

NS_ASSUME_NONNULL_END

#import "AMTOInput+CoreDataProperties.h"
