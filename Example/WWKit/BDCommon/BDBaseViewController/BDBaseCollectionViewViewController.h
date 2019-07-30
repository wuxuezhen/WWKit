//
//  BDBaseCollectionViewViewController.h
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/12.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "RootViewController.h"
#import "BDBaseProtocol.h"
@interface BDBaseCollectionViewViewController : RootViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BDCollectionViewProtocol,BDRefreshProtocol,BDNetConfigProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *dataArray;

-(void)bd_noInsetAdjustmentBehavior;

@end
