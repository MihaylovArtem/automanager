//
//  AMMaterialsInputView.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMMaterialsInputView.h"
#import "AMMaterialInput.h"
@interface AMMaterialsInputView() <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (strong,nonatomic) NSArray * pickerData;
@property (strong,nonatomic) UIPickerView * picker;

@end

@implementation AMMaterialsInputView


- (IBAction)closeTapped:(id)sender {
    [self removeFromSuperview];
}

- (void) configureView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(pickerDoneClicked:)];
    
    [self addGestureRecognizer:tap];
    self.pickerData = @[@"Расходные материалы", @"Запчасти", @"Ремонт", @"Внешний вид"];
    self.type.delegate = self;
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.type.inputView = self.picker;
    
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
    self.type.inputAccessoryView = keyboardDoneButtonView;
    self.km.inputAccessoryView = keyboardDoneButtonView;
    self.cost.inputAccessoryView = keyboardDoneButtonView;
}

-(void) resetView {
    self.type.text = @"";
    self.km.text = @"";
    self.cost.text = @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    row = [self.picker selectedRowInComponent:0];
    self.type.text = [self.pickerData objectAtIndex:row];
}
-(void)valueChanged:(UIDatePicker *)datePicker
{
    NSInteger row = [self.picker selectedRowInComponent:0];
    self.type.text = [self.pickerData objectAtIndex:row];
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
-(void) pickerDoneClicked:(id)sender {
    [self endEditing:YES];
}
- (IBAction)saveTapped:(id)sender {
    if ([self.type.text  isEqual: @""] || [self.cost.text isEqual:@""] || [self.km.text isEqual:@""]) {
        [self.delegate saveTap];
    } else {
        [AMMaterialInput initWithKm:[NSNumber numberWithInteger:[self.km.text integerValue]] Cost:[NSNumber numberWithFloat:[self.cost.text floatValue]] andType:self.type.text];
        [self.delegate saveTap2];
        [self removeFromSuperview];
    }

}


@end
