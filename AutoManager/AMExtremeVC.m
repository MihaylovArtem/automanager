//
//  AMExtremeVC.m
//  AutoManager
//
//  Created by Artem Mihajlov on 26.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMExtremeVC.h"
#import "AMExtreme.h"
#import "AMManualView.h"


@interface AMExtremeVC ()

@property (strong,nonatomic) NSArray *extremeContent;

@end

@implementation AMExtremeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray * contentArray = [@[] mutableCopy];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ExtremeJson" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    for (NSDictionary *manualDict in dict[@"result"]) {
        AMExtreme * manual = [AMExtreme initWithDictionary:manualDict];
        
        [contentArray addObject:manual];
    }
    self.extremeContent = contentArray;
}

-(void)configureViewWithExtreme:(AMExtreme*)extreme {
    AMManualView * view = [[[NSBundle mainBundle] loadNibNamed:@"AMManualView"
                                                         owner:self
                                                       options:nil] firstObject];
    view.desc.text = extreme.desc;
    NSURL *url = [NSURL URLWithString:extreme.image];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    view.image.image = img;
    [view.desc sizeToFit];
    view.from.text = [view.from.text stringByAppendingString:extreme.from];
    [self.view layoutSubviews];
    [self.view addSubview:view];
}

- (IBAction)dtp:(id)sender {
    [self configureViewWithExtreme:[self.extremeContent objectAtIndex:0]];
}
- (IBAction)par:(id)sender {
    [self configureViewWithExtreme:[self.extremeContent objectAtIndex:1]];
}

- (IBAction)wheel:(id)sender {
    [self configureViewWithExtreme:[self.extremeContent objectAtIndex:2]];
}
- (IBAction)police:(id)sender {
    [self configureViewWithExtreme:[self.extremeContent objectAtIndex:3]];
}


@end
