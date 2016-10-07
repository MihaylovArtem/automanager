//
//  AMWashInputView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMWashInputViewDelegate <NSObject>

@optional
-(void)saveTap;
-(void)saveTap2;

@end

@interface AMWashInputView : UIView

@property (strong, nonatomic) id <AMWashInputViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *cost;
@property (weak, nonatomic) IBOutlet UITextField *km;

- (void) configureView;
-(void) resetView;

@end
