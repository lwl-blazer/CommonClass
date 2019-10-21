//
//  TableViewController.m
//  CommonClass
//
//  Created by blazer on 2018/10/11.
//  Copyright © 2018 blazer. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "BLCustomActionSheet.h"

#import "BLActionSheetViewController.h"
#import "ActionSheetViewController.h"
#import "LinkedList.h"
#import "CircleLinkedList.h"

@interface TableViewController ()

@property(nonatomic, copy) NSArray *dataArr;

@property(nonatomic, copy) BLCustomActionSheet *sheet;
@property(nonatomic, strong) LinkedList *list;
@property(nonatomic, strong) CircleLinkedList *circleList;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.dataArr = @[@"1", @"2", @"3", @"4", @"5"];
    
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    head.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = head;
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView reloadData];
    
//    self.list = [[LinkedList alloc] init];
    
    self.circleList = [[CircleLinkedList alloc] init];
    
    [self.circleList addObject:@(30)];
    [self.circleList addObject:@(40)];
    [self.circleList addObject:@(50)];
    [self.circleList addObject:@(60)];
    [self.circleList addObject:@(70)];
    [self.circleList addObject:@(80)];
    [self.circleList insertObject:@(20) index:0];
    [self.circleList insertObject:@(10) index:0]; 
   
    NSInteger n = 2;
    while (self.circleList.size > 1) {
        for (NSInteger i = 0; i < n; i++) {
            [self.circleList currentNodeNext];
        }
        [self.circleList removeCurrentNodel];
    }
    NSLog(@"%@", self.circleList);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
 
    cell.textLabel.text = @"1111";*/
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell refreshData:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // [self.sheet showCustomActionSheet];
    
    ActionSheetViewController *sheet = [[ActionSheetViewController alloc] init];
    
    BLActionSheetViewController *action = [[BLActionSheetViewController alloc] initWithPresentedViewController:sheet presentingViewController:self];
    sheet.transitioningDelegate = action;
    [self presentViewController:sheet animated:YES completion:NULL];
    
    
}
- (BLCustomActionSheet *)sheet{
    if (!_sheet) {
        _sheet = [[BLCustomActionSheet alloc] init];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        bgView.backgroundColor = [UIColor redColor];
        _sheet.contentView = bgView;
        _sheet.supView = self.view;
        
    }
    return _sheet;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
