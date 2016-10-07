//
//  AMWashInputView.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMWashInputView.h"
#import "AMWashInput.h"
#import <MagicalRecord/MagicalRecord.h>

@interface AMWashInputView()<UITextFieldDelegate>

@end

@implementation AMWashInputView

- (IBAction)closeTapped:(id)sender {
    [self removeFromSuperview];
}

-(void)configureView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(pickerDoneClicked:)];
    
    [self addGestureRecognizer:tap];
    
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.barStyle = UIBarStyleDefault;
    keyboardDoneButtonView.translucent = YES;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                   style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(pickerDoneClicked:)];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpace,doneButton, nil]];
    self.km.inputAccessoryView = keyboardDoneButtonView;
    self.cost.inputAccessoryView = keyboardDoneButtonView;
}

-(void) resetView {
    self.km.text = @"";
    self.cost.text = @"";
}

-(void) pickerDoneClicked:(id)sender {
    [self endEditing:YES];
}

- (IBAction)saveTapped:(id)sender {
    if ([self.cost.text isEqual:@""] || [self.km.text isEqual:@""]) {
        [self.delegate saveTap];
    } else {
        [AMWashInput initWithKm:[NSNumber numberWithInteger:[self.km.text integerValue]] andCost:[NSNumber numberWithFloat:[self.cost.text floatValue]]];
        [self.delegate saveTap2];
        [self removeFromSuperview];
    }

}

@end
