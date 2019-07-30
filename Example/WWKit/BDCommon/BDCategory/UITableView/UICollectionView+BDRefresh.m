//
//  UICollectionView+BDRefresh.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/11.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "UICollectionView+BDRefresh.h"
#import "BDRefreshNormalHeader.h"
#import "BDRefreshnAutoNormalFooter.h"

@implementation UICollectionView (BDRefresh)

#pragma mark - BDMJRefreshProtocol
-(void)bd_headerRefreshTarget:(id)target selecter:(SEL)selecter{
    self.mj_header = [BDRefreshNormalHeader headerWithRefreshingTarget:target
                                                      refreshingAction:selecter];
}
-(void)bd_footerRefreshTarget:(id)target selecter:(SEL)selecter{
    self.mj_footer = [BDRefreshnAutoNormalFooter footerWithRefreshingTarget:target
                                                           refreshingAction:selecter];
}

-(void)endRefreshAllLoad:(BOOL)loaded{
    if (loaded) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    [self endRefreshForHeader];
    [self reloadData];
}

-(void)endRefresh{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
        self.mj_footer.state = MJRefreshStateIdle;
    }
    [self endRefreshForFooter];
    [self reloadData];
}

-(void)endRefreshForHeader{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
}

-(void)endRefreshForFooter{
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

-(void)beginRefreshing{
    [self.mj_header beginRefreshing];
}


#pragma mark - BDCellRegisterProtocol
-(void)registerClass:(Class)kClass{
    if (kClass) {
        [self registerClass:kClass forCellWithReuseIdentifier:NSStringFromClass(kClass)];
    }
}

-(void)registerNib:(Class)kClass{
    if (kClass) {
        NSString *nibName = NSStringFromClass(kClass);
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:nibName];
    }
}


@end


