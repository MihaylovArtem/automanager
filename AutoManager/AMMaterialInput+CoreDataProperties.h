//
//  AMMaterialInput+CoreDataProperties.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AMMaterialInput.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMMaterialInput (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cost;
@property (nullable, nonatomic, retain) NSNumber *km;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
