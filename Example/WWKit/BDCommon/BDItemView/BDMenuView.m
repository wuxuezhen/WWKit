//
//  BDMenuView.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/26.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDMenuView.h"
#import "BDMenuItemCell.h"
#import "WWGCDQueue.h"
@interface BDMenuView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) CGFloat lineStart;
@property (nonatomic, assign) CGFloat viewWidth;
@end
@implementation BDMenuView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _hiddenLine = NO;
        _titles     = titles;
        _itemHeight = frame.size.height;
        _viewWidth  = frame.size.width;
        [self bd_itemWidth:titles.count];
        bd_async_mainQueue(^{
            [self setUI];
        });
    }
    return self;
}

-(instancetype)initWithTitles:(NSArray *)titles{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _hiddenLine = NO;
        _titles     = titles;
        _itemHeight = 50.f;
        _viewWidth  = SCREEN_W;
        [self bd_itemWidth:titles.count];
        bd_async_mainQueue(^{
            [self setUI];
        });
    }
    return self;
}

-(instancetype)initWithTitles:(NSArray *)titles height:(CGFloat)itemHeight{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        _titles     = titles;
        _hiddenLine = NO;
        _itemHeight = itemHeight;
        _viewWidth  = SCREEN_W;
        [self bd_itemWidth:titles.count];
        [self setUI];
    }
    return self;
}

-(void)setUI{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.centerY.equalTo(self);
        make.bottom.equalTo(self).offset(-2);
    }];
    bd_async_mainQueue(^{
        [self.collectionView layoutIfNeeded];
    });
    
    CALayer *layer = [CALayer new];
    layer.backgroundColor = BD_RGB_HEX(0xcccccc).CGColor;
    layer.frame = CGRectMake(0, _itemHeight-0.5, _viewWidth, 0.5);
    [self.layer addSublayer:layer];
    [self addSubview:self.lineView];
    
}

-(void)setHiddenLine:(BOOL)hiddenLine{
    _hiddenLine = hiddenLine;
    self.lineView.hidden = hiddenLine;
}

-(void)setStyle:(BDMenuStyle)style{
    _style = style;
    [self.collectionView reloadData];
}

-(void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self bd_itemWidth:titles.count];
    [self.collectionView reloadData];
}

-(void)bd_itemWidth:(NSInteger)count{
    if (count > 0) {
        _itemWidth = _viewWidth/count;
    }else{
        _itemWidth = _viewWidth;
    }
    _lineStart = _itemWidth/2 - 13;
}

#pragma mark - collectionViewDetegate && UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BDMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BDMenuItemCell reuseIdentifier]
                                                                     forIndexPath:indexPath];
    cell.coverStyle = self.style == BDMenuStyleCover;
    cell.title      = [self.titles bd_objectAtIndex:indexPath.item];
    cell.selectItem = self.selectItem == indexPath.item;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_itemWidth, _itemHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ( self.selectItem != indexPath.item) {
         self.selectItem = indexPath.item;
    }
}

-(void)setSelectItem:(NSInteger)selectItem{
    _selectItem = selectItem;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.frame = CGRectMake(self.lineStart + self.itemWidth * selectItem, _itemHeight - 3, 26, 3);
    }];
    [self.collectionView reloadData];
    self.bd_selectBlock ? self.bd_selectBlock(selectItem, self.titles[selectItem]) : nil;
}

#pragma mark - 懒加载

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate  = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[BDMenuItemCell nib]
          forCellWithReuseIdentifier:[BDMenuItemCell reuseIdentifier]];
        
    }
    return _collectionView;
}

-(UIView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.lineStart, _itemHeight - 3, 26, 3)];
        _lineView.backgroundColor = [UIColor bd_orangeColor];
    }
    return _lineView;
}



//BDMenuItemCell *cell = (BDMenuItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
//CGRect cellInCollection = [collectionView convertRect:cell.frame
//                                               toView:collectionView];
//CGRect rect = [collectionView convertRect:cellInCollection toView:self];
//CGFloat x = rect.origin.x + rect.size.width/2;
//CGPoint center = self.lineView.center;
//center.x = x;
//self.lineView.center = center;
@end
