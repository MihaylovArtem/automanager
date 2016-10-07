//
//  AMFuelInput+CoreDataProperties.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AMFuelInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMFuelInput (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *fuelCost;
@property (nullable, nonatomic, retain) NSString *fuelType;
@property (nullable, nonatomic, retain) NSNumber *fuelVolume;
@property (nullable, nonatomic, retain) NSNumber *km;

@end

NS_ASSUME_NONNULL_END
