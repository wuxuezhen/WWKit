//
//  BDMJRefreshProtocol.h
//  BusinessDataPlatform
//
//  Created by wzz on 2018/12/13.
//  Copyright © 2018 donghui lv. All rights reserved.
//

#ifndef BDMJRefreshProtocol_h
#define BDMJRefreshProtocol_h

@protocol BDMJRefreshProtocol <NSObject>

-(void)bd_headerRefreshTarget:(id)target selecter:(SEL)selecter;
-(void)bd_footerRefreshTarget:(id)target selecter:(SEL)selecter;

-(void)endRefresh;
-(void)endRefreshAllLoad:(BOOL)loaded;

-(void)endRefreshForHeader;
-(void)endRefreshForFooter;

-(void)beginRefreshing;

@end


@protocol BDCellRegisterProtocol <NSObject>

-(void)registerNib:(Class)kClass;

-(void)registerClass:(Class)kClass;

@end

#endif /* BDMJRefreshProtocol_h */
