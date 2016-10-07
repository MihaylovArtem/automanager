//
//  AMManualView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 25.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMManualView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *from;

@end
