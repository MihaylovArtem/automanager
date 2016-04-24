//
//  AMSettingsVC.m
//  AutoManager
//
//  Created by Artem Mihajlov on 15.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMSettingsVC.h"
#import "AMSettingsCell.h"
#import <MessageUI/MessageUI.h>

static NSString * const AMSettingsCellIdentifier = @"AMSettingsCell";

@interface AMSettingsVC () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *settingsTable;
@property (strong, nonatomic) NSArray * pickerData;
@property (strong, nonatomic) NSArray * pickerDataModel;

@end

@implementation AMSettingsVC

    NSDate *_dueDate;

- (void)viewDidLoad {
    self.pickerData = @[@"Huyndai"];
    self.pickerDataModel = @[@"Solaris"];
    [super viewDidLoad];
    [self.settingsTable registerNib:[UINib nibWithNibName:AMSettingsCellIdentifier bundle:nil] forCellReuseIdentifier:AMSettingsCellIdentifier];
    self.settingsTable.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(pickerDoneClicked:)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMSettingsCell * cell = [tableView dequeueReusableCellWithIdentifier:AMSettingsCellIdentifier];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.name.placeholder =  @"Дата выдачи водительского удостоверения";
        cell.name.tag = 0;
        cell.name.delegate = self;
        UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        cell.name.inputView = datePicker;
        
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
        cell.name.inputAccessoryView = keyboardDoneButtonView;
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.name.placeholder =  @"Марка";
        cell.name.tag = 1;
        cell.name.delegate = self;
        UIPickerView * picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        picker.delegate = self;
        picker.dataSource = self;
        picker.tag = 0;
        cell.name.inputView = picker;
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
        cell.name.inputAccessoryView = keyboardDoneButtonView;
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        cell.name.placeholder =  @"Модель";
        cell.name.tag = 2;
        cell.name.delegate = self;
        UIPickerView * picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
        picker.delegate = self;
        picker.dataSource = self;
        picker.tag = 1;
        cell.name.inputView = picker;
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
        cell.name.inputAccessoryView = keyboardDoneButtonView;
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        cell.name.placeholder =  @"Дата покупки";
        cell.name.tag = 3;
        cell.name.delegate = self;
        UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker addTarget:self action:@selector(carDateChanged:) forControlEvents:UIControlEventValueChanged];
        cell.name.inputView = datePicker;
        UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
        keyboardDoneButtonView.barStyle = UIBarStyleDefault;
        keyboardDoneButtonView.translucent = YES;
        keyboardDoneButtonView.tintColor = nil;
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Готово"
                                                                       style:UIBarButtonItemStylePlain target:self
                                                                      action:@selector(pickerDoneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpace, doneButton, nil]];
//        [keyboardDoneButtonView se]
        cell.name.inputAccessoryView = keyboardDoneButtonView;
    }
    if (indexPath.section == 3) {
        cell.name.text =  @"";
        cell.name.textAlignment = NSTextAlignmentCenter;
        [cell.name setEnabled:NO];
        
        //UIButton * button = [[UIButton alloc] initWithFrame:cell.frame];
//        button.titleLabel.text = @"Обратная связь";
//        [button.titleLabel setFrame:button.frame];
//        button.titleLabel.textAlignment = NSTextAlignmentCenter;
//        button.titleLabel.font = [UIFont systemFontOfSize:16];
//        button.titleLabel.textColor = [UIColor blueColor];
//        [button.titleLabel setHidden:NO];
        cell.feedbackButton.hidden = NO;
        //[button setTitle:@"Обратная связь" forState:UIControlStateNormal];
        //[cell addSubview:button];
    }
    return cell;
}

-(void) pickerDoneClicked:(id)sender {
    [self.view endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        UIDatePicker * datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
//        datePicker.datePickerMode = UIDatePickerModeDate;
//        AMSettingsCell * cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.name.inputView = datePicker;
//        cell.name.text = [NSString stringWithFormat:@"%@", datePicker.date];
//    }
//}
-(void)dateChanged:(UIDatePicker *)datePicker
{
    _dueDate = datePicker.date;
    [self updateDueDateTextField];
}
-(void)carDateChanged:(UIDatePicker *)datePicker
{
    _dueDate = datePicker.date;
    [self carUpdateDueDateTextField];
}

- (void)updateDueDateTextField
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    AMSettingsCell *cell = [self.settingsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.name.text = [formatter stringFromDate:_dueDate];
}
- (void)carUpdateDueDateTextField
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    AMSettingsCell *cell = [self.settingsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    cell.name.text = [formatter stringFromDate:_dueDate];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 3;
    }
    if (section == 2 || section == 4 || section == 5 || section == 6 || section == 7) {
        return 0;
    }
    return 1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3 || indexPath.section == 4) {
        return NO;
    }
    return YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Водительское удостоверение";
    }
    if (section == 1) {
        return @"Информация об автомобиле";
    }
    return @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 2)) {
        [(AMSettingsCell*)[tableView cellForRowAtIndexPath:indexPath] name].text = [formatter stringFromDate:[NSDate date]];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [(AMSettingsCell*)[tableView cellForRowAtIndexPath:indexPath] name].text = @"Huyndai";
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [(AMSettingsCell*)[tableView cellForRowAtIndexPath:indexPath] name].text = @"Solaris";
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    if (textField.tag == 0 || textField.tag == 3) {
        textField.text = [formatter stringFromDate:[NSDate date]];
    }
    if (textField.tag == 1) {
        textField.text = @"Huyndai";
    }
    if (textField.tag == 2) {
        textField.text = @"Solaris";
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - pickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerView.tag == 0? self.pickerData[row] : self.pickerDataModel[row];
}
- (IBAction)feedbackButtonTapped:(id)sender {
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:@[@"MihaylovArtem74@gmail.com"]];
        [mailCont setSubject:@"AutoManager"];
        [mailCont setMessageBody:@"" isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                       message:@"С данного устройства невозможно отправить e-mail"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
