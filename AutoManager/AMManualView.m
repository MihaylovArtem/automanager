//
//  AMManualView.m
//  AutoManager
//
//  Created by Artem Mihajlov on 25.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMManualView.h"

@implementation AMManualView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)close:(id)sender {
    [self removeFromSuperview];
}

@end
