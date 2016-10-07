//
//  AMManual+CoreDataProperties.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AMManual.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMManual (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *from;

@end

NS_ASSUME_NONNULL_END
