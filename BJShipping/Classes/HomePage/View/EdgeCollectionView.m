//
//  EdgeCollectionView.m
//  BJShipping
//
//  Created by UEdge on 2017/10/17.
//  Copyright © 2017年 UEdge. All rights reserved.
//

/**每个item的水平间距*/
#define Margin_W 4
/**每个item的垂直间距*/
#define Margin_H 20

#import "EdgeCollectionView.h"
#import "EdgeCollectionViewCell.h"
#import "UserModel.h"
//#import "EdgeWarnInfoViewController.h"


NSString * const CollectionViewCell = @"EdgeCollectionViewCell";

@interface EdgeCollectionView()<UICollectionViewDataSource, UICollectionViewDelegate>

/**功能菜单的collectionView*/
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end

@implementation EdgeCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMainView];
    }
    return self;
}
//设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 竖值距离
    flowLayout.minimumLineSpacing = Margin_H;
    //  水平的距离
    flowLayout.minimumInteritemSpacing = Margin_W;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//水平方向
    
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerNib:[UINib nibWithNibName:CollectionViewCell bundle:nil] forCellWithReuseIdentifier:CollectionViewCell];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    
    _mainView = mainView;
}

-(void)reloadData{
    
    //    [self dataInit];
    [_mainView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.frame.size;
    
    _mainView.frame = self.bounds;
    
}
#pragma mark ------------设置collecView代理方法-----------------
//配置每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.frame.size.width/4 - Margin_W*3;
    CGFloat height = width ;
    if (height * 3 >= self.frame.size.height) {
        height = self.frame.size.height / 3 - Margin_H*3;
    }
    
    return CGSizeMake( width, height);
}

//配置item的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 15, 15, 15);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.typeItemArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    EdgeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCell forIndexPath:indexPath];
    
    cell.collectionModel = self.typeItemArray[indexPath.row];
    
    if (indexPath.row == 2) {// 调度信息
        
        cell.messageCountLabel.text  = self.messageCount;
        
        if (cell.messageCountLabel.text.intValue<=0) {
            cell.messageCountLabel.hidden = YES;
        }else{
            cell.messageCountLabel.hidden = NO;
        }
    }else{
        cell.messageCountLabel.hidden = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //调用
    if (self.clickCellCb) {
        EdgeCollectionModel *item = [self.typeItemArray objectAtIndex:indexPath.row];
        self.clickCellCb((int)indexPath.row , item);
    }
}

-(NSArray *)typeItemArray{
    
    if (!_typeItemArray) {
        
        _typeItemArray = [[NSArray alloc]init];
        
        
        _typeItemArray = [EdgeCollectionModel getHomeCollectionViewMenuArray:[UserModel getUserModel].getUserType];
        
    }
    return _typeItemArray;
}


@end
