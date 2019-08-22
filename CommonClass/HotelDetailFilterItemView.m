//
//  HotelDetailFilterItemView.m
//  bee2clos
//
//  Created by luowailin on 2019/8/16.
//

#import "HotelDetailFilterItemView.h"
#import <Masonry/Masonry.h>

#import "HotelDetailFilterItemCell.h"
#import "HotelDetailFilterItemLayout.h"

@interface HotelDetailFilterItemView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectView;

@property(nonatomic, strong) NSMutableArray <NSDictionary *>*datas;
@property(nonatomic, strong) NSMutableArray <NSIndexPath *>*selectIndexPaths;

@property(nonatomic, copy) NSArray <NSDictionary *>*oldDatas;
@property(nonatomic, copy) NSDictionary *weakDic;

@property(nonatomic, assign) NSInteger insertNumber;

@end

@implementation HotelDetailFilterItemView //h:40

- (instancetype)initWithFrame:(CGRect)frame buttons:(NSArray <NSString *>*)buttons;
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSString *str in buttons) {
            [self.datas addObject:@{@"name": str,
                                    @"select": [NSNumber numberWithBool:NO]}];
        }
        self.oldDatas = [NSArray arrayWithArray:self.datas.copy];
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    [self addSubview:self.collectView];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark -- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotelDetailFilterItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemCell" forIndexPath:indexPath];
    cell.model = self.datas[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self operationCollectionViewCellWithSelectIndex:indexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    self.weakDic = self.datas[indexPath.row];
    NSString *name = [self.weakDic objectForKey:@"name"];
    CGFloat w =  [name boundingRectWithSize:CGSizeMake(MAXFLOAT, 24.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}
                                    context:nil].size.width + 20;
    return CGSizeMake(w, 40.0);
}

- (void)insertSelectFilterItemWithIndex:(NSInteger)row itemName:(nonnull NSString *)name{
    
    for (NSDictionary *dic in self.datas) {
        if ([name isEqualToString:dic[@"name"]]) { //如果存在这个选项，就不处理
            return;
        }
    }
    self.insertNumber ++;
    [self.datas insertObject:@{@"name":name,
                               @"select": [NSNumber numberWithBool:YES]
                               } atIndex:0];
    [CATransaction setDisableActions:YES];
    [self.collectView performBatchUpdates:^{
        [self.collectView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]];
    } completion:^(BOOL finished) {
        [CATransaction commit];
        [self.selectIndexPaths insertObject:[NSIndexPath indexPathForRow:0 inSection:0] atIndex:0];
        [self operationSelectIndexPathsIsRemovePath:nil];
    }];
}

- (void)operationCollectionViewCellWithSelectIndex:(NSIndexPath *)indexPath{
    self.weakDic = self.datas[indexPath.row];
    BOOL select = [self.weakDic[@"select"] boolValue];
    NSString *name = self.weakDic[@"name"];
    [self collectionViewReloadIndexPath:indexPath object:@{@"name":name,
                                                           @"select":[NSNumber numberWithBool:!select]
                                                           }];
    
    NSIndexPath *changePath = nil;
    if (select) { //取消选中
        NSInteger i = 0;
        NSInteger row = -1;
        NSDictionary *dic = nil;
        for (dic in self.oldDatas) {
            if ([dic[@"name"] isEqualToString:name]) {
                row = i;
                break;
            }
            i ++;
        }
        
        [self operationSelectIndexPathsIsRemovePath:indexPath];

        if (row >= 0) {
            NSInteger location = 0; //存放的位置
            if(row > 0){
                name = [self.oldDatas[row - 1] objectForKey:@"name"];
                i = 0;
                for (dic in self.datas) {
                    if ([dic[@"name"] isEqualToString:name]) {
                        if ([dic[@"select"] boolValue]) {
                            location = self.selectIndexPaths.count;
                        } else {
                            location = i;
                        }
                        break;
                    }
                    i++;
                }
                changePath = [NSIndexPath indexPathForRow:location  inSection:0];
            }
        } else {
            [self collectionViewDeleteIndexPath:indexPath];
        }
    } else { //选中
        if (self.selectIndexPaths.count > 0) {
            changePath = self.selectIndexPaths[self.selectIndexPaths.count - 1];
            changePath = [NSIndexPath indexPathForRow:changePath.row + 1 inSection:changePath.section];
        } else {
            changePath = [NSIndexPath indexPathForRow:0 inSection:0];
        }
        [self.selectIndexPaths addObject:changePath];
        [self operationSelectIndexPathsIsRemovePath:nil];
    }
    
    if (changePath && indexPath.row != changePath.row) {
        [self collectionViewMoveItemAtIndexPath:indexPath toIndexPath:changePath];
    }
}

- (void)collectionViewReloadIndexPath:(NSIndexPath *)indexPath object:(NSDictionary *)object{
    [self.datas replaceObjectAtIndex:indexPath.row
                          withObject:object];
    [CATransaction setDisableActions:YES];
    [self.collectView performBatchUpdates:^{
        [self.collectView reloadItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [CATransaction commit];
    }];
}

- (void)collectionViewMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSDictionary *dic = self.datas[indexPath.row];
    [self.datas removeObjectAtIndex:indexPath.row];
    [self.datas insertObject:dic atIndex:toIndexPath.row];
    
    [CATransaction setDisableActions:YES];
    [self.collectView performBatchUpdates:^{
        [self.collectView moveItemAtIndexPath:indexPath toIndexPath:toIndexPath];
    } completion:^(BOOL finished) {
        [CATransaction commit];
    }];
}

- (void)collectionViewDeleteIndexPath:(NSIndexPath *)indexPath{
    [self.datas removeObjectAtIndex:indexPath.row];
    [CATransaction setDisableActions:YES];
    [self.collectView performBatchUpdates:^{
        [self.collectView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [CATransaction commit];
    }];
}

     - (void)operationSelectIndexPathsIsRemovePath:(NSIndexPath *)movePath {
    if (self.selectIndexPaths.count <= 0) {
        return;
    }
    if (movePath) {
        for (NSIndexPath *path in self.selectIndexPaths) {
            if (path.row == movePath.row) {
                [self.selectIndexPaths removeObject:path];
                break;
            }
        }
    }
    
    for (NSInteger i = 0; i < self.selectIndexPaths.count; i ++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:i
                                               inSection:0];
        [self.selectIndexPaths replaceObjectAtIndex:i withObject:path];
    }
}

#pragma mark -- init

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

- (NSMutableArray<NSIndexPath *> *)selectIndexPaths{
    if (!_selectIndexPaths) {
        _selectIndexPaths = [[NSMutableArray alloc] init];
    }
    return _selectIndexPaths;
}

- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *layerout = [[UICollectionViewFlowLayout alloc] init];
        layerout.minimumInteritemSpacing = 8.0;
        layerout.estimatedItemSize = CGSizeMake(60, 40);
        layerout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:layerout];
        _collectView.backgroundColor = [UIColor colorWithRed:237/255.0
                                                       green:243/255.0
                                                        blue:251/255.0
                                                       alpha:1.0];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.showsHorizontalScrollIndicator = NO;
        [_collectView registerClass:[HotelDetailFilterItemCell class] forCellWithReuseIdentifier:@"itemCell"];
    }
    return _collectView;
}

@end
