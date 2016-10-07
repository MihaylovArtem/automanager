//
//  AMManualVC.m
//  AutoManager
//
//  Created by Artem Mihajlov on 15.04.16.
//  Copyright © 2016 Program Ingeneering. All rights reserved.
//

#import "AMManualVC.h"
#import "AMManual.h"
#import "AMSettingsCell.h"
#import "AMManualView.h"
#import <MagicalRecord/MagicalRecord.h>

static NSString * const AMSettingsCellIdentifier = @"AMSettingsCell";

@interface AMManualVC () <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *manualContent;
@property (strong, nonatomic) NSArray *searchResults;

@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation AMManualVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchDisplayController.searchBar.delegate = self;
    self.searchDisplayController.delegate = self;
    
    NSMutableArray * contentArray = [@[] mutableCopy];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ManualJson" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    
    for (NSDictionary *manualDict in dict[@"result"]) {
        AMManual * manual = [AMManual initWithDictionary:manualDict];

        [contentArray addObject:manual.name];
    }
    self.manualContent = contentArray;
    
    
    [self.manualTable registerNib:[UINib nibWithNibName:AMSettingsCellIdentifier bundle:nil] forCellReuseIdentifier:AMSettingsCellIdentifier];
    
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:AMSettingsCellIdentifier bundle:nil] forCellReuseIdentifier:AMSettingsCellIdentifier];
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
    self.searchResults = [self.manualContent filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - tableView delegates
//метод делегата класса UITableView, который отвечает за настройку ячеек таблицы
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AMSettingsCell * cell = [tableView dequeueReusableCellWithIdentifier:AMSettingsCellIdentifier];
    
    NSString *manual;
    //если поиск активен, в ячейку записываем значения из массива результатов поиска, иначе - из массива всех значений
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        manual = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        manual = [self.manualContent objectAtIndex:indexPath.row];
    }
    
    cell.name.text = manual;
    cell.descWidth.constant = -8;
    [cell.name setEnabled:NO];
    return cell;
}
//метод делегата класса UITableView, который отвечает за высоту ячейки таблицы
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
//метод делегата класса UITableView, который отвечает за количество секций в таблице
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//метод делегата класса UITableView, который отвечает за количество ячеек в каждой секции
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.manualContent count];
    }
}
//метод делегата класса UITableView, который обрабатывает нажатие на ячейку таблицы
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AMManualView * view = [[[NSBundle mainBundle] loadNibNamed:@"AMManualView"
                                                        owner:self
                                                       options:nil] firstObject];
    AMSettingsCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    AMManual * manual = [AMManual MR_findFirstByAttribute:@"name" withValue:cell.name.text];
    view.desc.text = manual.desc;
    NSURL *url = [NSURL URLWithString:manual.image];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    view.image.image = img;
    [view.desc sizeToFit];
    view.from.text = [view.from.text stringByAppendingString:manual.from];
    [self.view layoutSubviews];
    [self.view addSubview:view];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    
}

-(void) pickerDoneClicked:(id)sender {
    [self.view endEditing:YES];
}


@end
