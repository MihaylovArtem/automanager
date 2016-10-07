//
//  AMFuelInputView.m
//  AutoManager
//
//  Created by Artem Mihajlov on 25.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMFuelInputView.h"
#import "AMFuelInput.h"

@interface AMFuelInputView() <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (strong,nonatomic) NSArray * pickerData;
@property (strong,nonatomic) UIPickerView * picker;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AMFuelInputView

- (IBAction)closeTapped:(id)sender {
    [self removeFromSuperview];
}

-(void)configureView {
    
    //[self.saveButton addTarget:self.delegate action:@selector(saveTap) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(pickerDoneClicked:)];
    
    [self addGestureRecognizer:tap];
    self.pickerData = @[@"Бензин АИ-92", @"Бензин АИ-95", @"Бензин АИ-98", @"Газ"];
    self.fuelType.delegate = self;
    
    
    //UIPickerView * picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    
    self.fuelType.inputView = self.picker;
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
    self.fuelType.inputAccessoryView = keyboardDoneButtonView;
    self.volume.inputAccessoryView = keyboardDoneButtonView;
    self.cost.inputAccessoryView = keyboardDoneButtonView;
    self.km.inputAccessoryView = keyboardDoneButtonView;
    
}

-(void)resetView {
    self.fuelType.text = @"";
    self.cost.text = @"";
    self.volume.text = @"";
    self.km.text = @"";
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger row = [self.picker selectedRowInComponent:0];
    self.fuelType.text = [self.pickerData objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    row = [self.picker selectedRowInComponent:0];
    self.fuelType.text = [self.pickerData objectAtIndex:row];
}

-(void) pickerDoneClicked:(id)sender {
    [self endEditing:YES];
}

-(void)valueChanged:(UIDatePicker *)datePicker
{
    NSInteger row = [self.picker selectedRowInComponent:0];
    self.fuelType.text = [self.pickerData objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerData.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerData[row];
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (IBAction)saveTapped:(id)sender {
    
    if ([self.fuelType.text  isEqual: @""] || [self.volume.text isEqual:@""] || [self.cost.text isEqual:@""] || [self.km.text isEqual:@""]) {
        [self.delegate saveTap];
    } else {
        [AMFuelInput initWithType:self.fuelType.text volume:[NSNumber numberWithFloat:[self.volume.text floatValue]] Km:[NSNumber numberWithInteger:[self.km.text integerValue]] andCost:[NSNumber numberWithFloat:[self.cost.text floatValue]]];
        [self.delegate saveTap2];
        [self removeFromSuperview];
    }
}
@end
