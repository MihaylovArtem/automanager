//
//  AMUserSettings+CoreDataProperties.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AMUserSettings.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMUserSettings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *docDate;
@property (nullable, nonatomic, retain) NSDate *carDate;
@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) NSString *mark;

@end

NS_ASSUME_NONNULL_END
