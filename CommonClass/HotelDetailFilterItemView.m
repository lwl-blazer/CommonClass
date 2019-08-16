//
//  HotelDetailFilterItemView.m
//  bee2clos
//
//  Created by luowailin on 2019/8/16.
//

#import "HotelDetailFilterItemView.h"
#import <Masonry/Masonry.h>

#import "HotelDetailFilterItemCell.h"

@interface HotelDetailFilterItemView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectView;

@property(nonatomic, strong) NSMutableArray <NSDictionary *>*datas;
@property(nonatomic, copy) NSArray <NSDictionary *>*oldDatas;

@property(nonatomic, copy) NSDictionary *weakDic;

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
    self.weakDic = self.datas[indexPath.row];
    BOOL select = [self.weakDic[@"select"] boolValue];
    [self.datas replaceObjectAtIndex:indexPath.row
                          withObject:@{@"name":self.weakDic[@"name"],
                                       @"select":[NSNumber numberWithBool:!select]}];
    
    [UIView setAnimationsEnabled:NO];
    [self.collectView performBatchUpdates:^{
        [self.collectView reloadItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [UIView setAnimationsEnabled:YES];
    }];
}

#pragma mark -- init

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}

- (UICollectionView *)collectView{
    if (!_collectView) {
        UICollectionViewFlowLayout *layerout = [[UICollectionViewFlowLayout alloc] init];
        layerout.minimumInteritemSpacing = RATENUM(8.0);
        layerout.estimatedItemSize = CGSizeMake(RATENUM(60), RATENUM(40));
        layerout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:layerout];
        _collectView.backgroundColor = SMARTAlphaGrayColor(237, 243, 251, 1.0);
        _collectView.delegate = self;
        _collectView.dataSource = self;
        _collectView.showsHorizontalScrollIndicator = NO;
        [_collectView registerClass:[HotelDetailFilterItemCell class] forCellWithReuseIdentifier:@"itemCell"];
    }
    return _collectView;
}

@end
