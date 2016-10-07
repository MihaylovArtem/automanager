//
//  AMTOInputView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMTOInputViewDelegate <NSObject>

@optional
-(void)saveTap;
-(void)saveTap2;

@end

@interface AMTOInputView : UIView

@property (strong, nonatomic) id <AMTOInputViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *cost;
@property (weak, nonatomic) IBOutlet UITextField *km;

-(void) configureView;
-(void) resetView;

@end
