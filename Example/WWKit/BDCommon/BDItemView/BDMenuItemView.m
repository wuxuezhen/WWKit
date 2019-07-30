//
//  BDMenuItemView.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/6/13.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDMenuItemView.h"
#import "BDMenuItemCollectionViewCell.h"
#import "BDMenuItemTextCell.h"

@interface BDMenuItemView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, assign) CGFloat minSpacing;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) BDMenuItemStyle style;
@end

@implementation BDMenuItemView

-(instancetype)initWithHeight:(CGFloat)height minSpacing:(CGFloat)minSpacing{
    if (self = [super init]) {
        _style           = BDMenuItemStyleNormal;
        _itemSize.height = height;
        _minSpacing      = minSpacing;
        [self bd_initUI];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(BDMenuItemStyle)style minSpacing:(CGFloat)minSpacing{
    if (self = [super initWithFrame:frame]) {
        _style           = style;
        _itemSize.height = CGRectGetHeight(frame);
        _minSpacing      = minSpacing;
        [self bd_initUI];
    }
    return self;
}

-(void)bd_initUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
    }];
}

-(void)bd_setTitles:(NSArray *)titles imageNames:(NSArray *)imageNames{
    _titles     = titles;
    _imageNames = imageNames;
    CGFloat height = CGRectGetHeight(self.frame);
    
    if (self.style == BDMenuItemStyleText) {
        _itemSize.width  = SCREEN_W/3 - 1;
        _itemSize.height = titles.count > 3 ? height/2 -1 :height;
    }else{
        if (titles.count > 0) {
            _itemSize.width  = (SCREEN_W - (titles.count -1) * _minSpacing)/titles.count;
        }else{
            _itemSize.width = 0;
        }
    }
    [self.collectionView reloadData];
}

#pragma mark - collectionViewDetegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.style == BDMenuItemStyleText) {
        BDMenuItemTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BDMenuItemTextCell reuseIdentifier]
                                                                         forIndexPath:indexPath];
        if (self.titles.count > indexPath.item) {
            cell.title = self.titles[indexPath.item];
        }
        return cell;
    }else{
        BDMenuItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BDMenuItemCollectionViewCell reuseIdentifier]
                                                                                       forIndexPath:indexPath];
        if (self.titles.count > indexPath.item) {
            [cell bd_setTitle:self.titles[indexPath.item]
                    imageName:[self.imageNames bd_objectAtIndex:indexPath.item]];
        }
        return cell;
    }
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _itemSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.titles.count > indexPath.item && self.bd_selectItemBlock) {
        self.bd_selectItemBlock(indexPath.item, self.titles[indexPath.item]);
    }
}

#pragma mark - 懒加载

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero
                                            collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate  = self;
        _collectionView.backgroundColor = BD_RGB_HEX(0xEDEDED);
        [_collectionView registerNib:[BDMenuItemCollectionViewCell nib]
          forCellWithReuseIdentifier:[BDMenuItemCollectionViewCell reuseIdentifier]];
        [_collectionView registerNib:[BDMenuItemTextCell nib]
          forCellWithReuseIdentifier:[BDMenuItemTextCell reuseIdentifier]];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.sectionInset    = UIEdgeInsetsZero;
        if (self.style == BDMenuItemStyleText){
            _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }else{
            _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
        _layout.minimumInteritemSpacing = 1;
        _layout.minimumLineSpacing = self.minSpacing;
    }
    return _layout;
}
@end
