//
//  AMInputVCViewController.m
//  AutoManager
//
//  Created by Artem Mihajlov on 25.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMInputVC.h"
#import "AMFuelInputView.h"
#import "AMFuelInput.h"
#import <MagicalRecord/MagicalRecord.h>
#import "AMMaterialsInputView.h"
#import "AMMaterialInput.h"
#import "AMTOInputView.h"
#import "AMTOInput.h"
#import "AMWashInput.h"
#import "AMWashInputView.h"

@interface AMInputVC () <AMFuelInputViewDelegate, AMMaterialInputViewDelegate, AMTOInputViewDelegate, AMWashInputViewDelegate>

@property (strong,nonatomic) AMFuelInputView * fuelView;
@property (strong,nonatomic) AMMaterialsInputView * materialView;
@property (strong,nonatomic) AMTOInputView * toView;
@property (strong,nonatomic) AMWashInputView * washView;

@end

@implementation AMInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fuelView = [[[NSBundle mainBundle] loadNibNamed:@"AMFuelInputView" owner:self options:0] firstObject];
    [self.fuelView configureView];
    self.materialView = [[[NSBundle mainBundle] loadNibNamed:@"AMMaterialInputView" owner:self options:0] firstObject];
    [self.materialView configureView];
    self.toView = [[[NSBundle mainBundle] loadNibNamed:@"AMTOInputView" owner:self options:0] firstObject];
    [self.toView configureView];
    self.washView = [[[NSBundle mainBundle] loadNibNamed:@"AMWashInputView" owner:self options:0] firstObject];
    
    self.fuelView.delegate = self;
    self.materialView.delegate = self;
    self.toView.delegate = self;
    self.washView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fuelButtonTapped:(id)sender {
    
    [self.fuelView resetView];
    [self.view addSubview:self.fuelView];
}
- (IBAction)materialButtonTapped:(id)sender {
    [self.materialView resetView];
    [self.view addSubview:self.materialView];
}
- (IBAction)toButtonTapped:(id)sender {
    [self.toView resetView];
    [self.view addSubview:self.toView];
}
- (IBAction)washButtonTapped:(id)sender {
    [self.washView resetView];
    [self.view addSubview:self.washView];
}

-(void)saveTap {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Ошибка"
                                                                   message:@"Чтобы сохранить введенные данные, необходимо заполнить все поля"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)saveTap2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Поздравляем!"
                                                                   message:@"Введенные данные сохранены успешно!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
