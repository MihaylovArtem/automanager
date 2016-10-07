//
//  AMManual.h
//  AutoManager
//
//  Created by Artem Mihajlov on 24.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMManual : NSManagedObject

+(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "AMManual+CoreDataProperties.h"
