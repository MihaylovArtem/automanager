//
//  AMSettingsCell.h
//  AutoManager
//
//  Created by Artem Mihajlov on 15.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMSettingsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *feedbackButton;

@end
