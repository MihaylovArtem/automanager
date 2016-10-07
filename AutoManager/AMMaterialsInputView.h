//
//  AMMaterialsInputView.h
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AMMaterialInputViewDelegate <NSObject>

@optional
-(void)saveTap;
-(void)saveTap2;

@end

@interface AMMaterialsInputView : UIView

@property (strong, nonatomic) id <AMMaterialInputViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *cost;
@property (weak, nonatomic) IBOutlet UITextField *type;
@property (weak, nonatomic) IBOutlet UITextField *km;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

- (void) configureView;
-(void) resetView;

@end
