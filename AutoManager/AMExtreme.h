//
//  AMExtreme.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMExtreme : NSManagedObject

+(instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "AMExtreme+CoreDataProperties.h"
