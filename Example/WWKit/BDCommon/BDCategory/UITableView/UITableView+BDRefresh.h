//
//  UITableView+BDRefresh.h
//  AZURestWeidu3
//
//  Created by 吴振振 on 2017/12/11.
//  Copyright © 2017年 coreface. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDMJRefreshProtocol.h"
@interface UITableView (BDRefresh)<BDMJRefreshProtocol,BDCellRegisterProtocol>

@end
