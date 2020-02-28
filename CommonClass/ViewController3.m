//
//  ViewController3.m
//  CommonClass
//
//  Created by luowailin on 2019/12/25.
//  Copyright © 2019 blazer. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController2.h"
@interface ViewController3 ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view addSubview:self.tableView];
    //[self settingSearchController];
 
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self.view addSubview:btn];
    btn.center = self.view.center;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)btnAction{
    ViewController2 *ctn = [[ViewController2 alloc] init];
    ctn.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:ctn animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"__%s__", __func__);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"__%s__", __func__);
}

- (void)settingSearchController{
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.definesPresentationContext = YES;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.searchResultsUpdater = self;
    searchController.searchBar.barTintColor = [UIColor whiteColor];
    searchController.searchBar.placeholder = @"中文/拼音/首字母";
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    if (@available(iOS 13.0, *)) {
        searchController.automaticallyShowsCancelButton = YES;
    }

    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    [vi addSubview:searchController.searchBar];
    [self.view addSubview:vi];
    //self.tableView.tableHeaderView = searchController.searchBar;
    
}

#pragma mark -- UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}



#pragma mark -- UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"111111");
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *chooseCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    chooseCell.textLabel.text = @"2";
    return chooseCell;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 80;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

@end
