//
//  AMTOInputView.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMTOInputView.h"
#import "AMTOInput.h"

@interface AMTOInputView() <UITextFieldDelegate>

@end

@implementation AMTOInputView

    NSDate *_dateForPicker;

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
    self.date.inputAccessoryView = keyboardDoneButtonView;
    self.km.inputAccessoryView = keyboardDoneButtonView;
    self.cost.inputAccessoryView = keyboardDoneButtonView;
    
    UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.date.inputView = datePicker;


    
}

-(void)dateChanged:(UIDatePicker *)datePicker
{
    _dateForPicker = datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.date.text = [formatter stringFromDate:_dateForPicker];
}

-(void) resetView {
    self.date.text = @"";
    self.km.text = @"";
    self.cost.text = @"";
}

-(void) pickerDoneClicked:(id)sender {
    [self endEditing:YES];
}

- (IBAction)closeTapped:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)saveTapped:(id)sender {
    if ([self.date.text  isEqual: @""] || [self.cost.text isEqual:@""] || [self.km.text isEqual:@""]) {
        [self.delegate saveTap];
    } else {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterMediumStyle;
        [AMTOInput initWithKm:[NSNumber numberWithInteger:[self.km.text integerValue]] Cost:[NSNumber numberWithFloat:[self.cost.text floatValue]] andDate:[formatter dateFromString:self.date.text]];
        [self.delegate saveTap2];
        [self removeFromSuperview];
    }
}

@end
