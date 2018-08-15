//
//  SelectTeacherView.m
//  ZuoYe
//
//  Created by vision on 2018/8/9.
//  Copyright © 2018年 vision. All rights reserved.
//

#import "SelectTeacherView.h"
#import "TeacherCollectionViewCell.h"
#import "LevelModel.h"

@interface SelectTeacherView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView      *myCollectionView;


@end

@implementation SelectTeacherView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        self.myCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.myCollectionView.showsHorizontalScrollIndicator = NO;
        self.myCollectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
        [self.myCollectionView registerClass:[TeacherCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TeacherCollectionViewCell class])];
        [self.myCollectionView setBackgroundColor:[UIColor clearColor]];
        [self.myCollectionView setDelegate:self];
        [self.myCollectionView setDataSource:self];
        [self addSubview:self.myCollectionView];
    }
    return self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.levelsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeacherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TeacherCollectionViewCell class]) forIndexPath:indexPath];
    
    LevelModel *model = self.levelsArray[indexPath.row];
    cell.levelLabel.text = model.level;
    cell.headImageView.image = [UIImage imageNamed:model.head_image];
    cell.priceLabel.text = [NSString stringWithFormat:@"%.1f元/分钟",model.price];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LevelModel *model = self.levelsArray[indexPath.row];
    MyLog(@"didSelectItemAtIndexPath -- 教师等级：%@，价格：%.1f",model.level,model.price);
    self.selLevelBlock(model);
}

#pragma mark UICollectionViewDelegateFlowLayout
#pragma mark 水平排放(变成一排展示)
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 150);
}

#pragma mark  使前后项都能居中显示
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount-1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width)/2, 0, (collectionView.bounds.size.width - lastSize.width)/2);
}

-(void)setLevelsArray:(NSMutableArray *)levelsArray{
    _levelsArray = levelsArray;
    if (levelsArray) {
        levelsArray = [[NSMutableArray alloc] init];
    }
    [self.myCollectionView reloadData];
}

@end
