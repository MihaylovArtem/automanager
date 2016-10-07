//
//  AMFuelInputView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 25.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMFuelInputViewDelegate <NSObject>

@optional
-(void)saveTap;
-(void)saveTap2;

@end

@interface AMFuelInputView : UIView

@property (strong, nonatomic) id <AMFuelInputViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *fuelType;
@property (weak, nonatomic) IBOutlet UITextField *volume;
@property (weak, nonatomic) IBOutlet UITextField *cost;
@property (weak, nonatomic) IBOutlet UITextField *km;

-(void)configureView;
-(void)resetView;

@end
