//
//  BDBaseTableViewController.h
//
//  Created by 吴振振 on 2017/11/30.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import "RootViewController.h"
#import "BDBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface BDBaseTableViewController : RootViewController<UITableViewDelegate,UITableViewDataSource,BDTableViewProtocol,BDRefreshProtocol,BDNetConfigProtocol>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;

-(void)bd_noInsetAdjustmentBehavior;

@end

NS_ASSUME_NONNULL_END
