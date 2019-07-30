//
//  BDBaseProtocol.h
//  BusinessDataPlatform
//
//  Created by wzz on 2018/12/13.
//  Copyright © 2018 donghui lv. All rights reserved.
//

#ifndef BDBaseProtocol_h
#define BDBaseProtocol_h

#pragma mark - BDTableViewProtocol
@protocol BDTableViewProtocol <NSObject>

-(void)bd_tableViewDefaut;
-(void)bd_tableViewForFill;

/** tableView的风格 默认plain **/
-(UITableViewStyle)tableViewStyle;

@end


#pragma mark - BDCollectionViewProtocol
@protocol BDCollectionViewProtocol <NSObject>

-(void)bd_collectionViewDefault;

-(void)bd_collectionViewForFill;

-(UICollectionViewScrollDirection)scrollDirection;

-(CGFloat)minimumInteritemSpacing;

-(CGFloat)minimumLineSpacing;

@end


#pragma mark - BDRefreshProtocol
@protocol BDRefreshProtocol <NSObject>

#pragma mark - 分页刷新
/** 分页刷新 包含上拉，下拉 事件已经实现 **/
-(void)mj_pageRefresh;

/** 分页刷新 包含上拉事件已经实现 **/
-(void)mj_pageRefreshForFooter;

/** 分页刷新 包含下拉事件已经实现 **/
-(void)mj_pageRefreshForHeader;

#pragma mark - 普通刷新 需要实现上拉，下拉事件
/** 普通刷新 需要实现上拉，下拉事件**/
-(void)mj_refresh;

/** MJHeader刷新 需要实现下拉事件**/
-(void)mj_headerRefresh;

/** MJFooter刷新 需要实现上拉事件**/
-(void)mj_footerRefresh;

/** 下拉事件**/
-(void)mj_headerRefreshAction;

/** 上拉事件**/
-(void)mj_footerRefreshAction;

/** 第一次下拉刷新 需要调用下来刷新**/
-(void)bd_beginLoadRequest;

/** 刷新数据 **/
-(void)bd_refreshData;

@end

#pragma mark - BDNetConfigProtocol
@protocol BDNetConfigProtocol <NSObject>

/** 分页请求的URL **/
-(NSString *)bd_pageUrl;

/** 数据解析key **/
-(NSString *)bd_parsingKey;

/** 分页请求的params 参数 **/
-(NSDictionary *)bd_params;

/** 数据转型后得到model类 **/
-(Class)bd_pageModelClass;

@end


#pragma mark - BDNibProtocol
@protocol BDNibProtocol <NSObject>
+ (UINib *)nib;
+ (NSString *)reuseIdentifier;
@end


#pragma mark - BDRegisterCellProtocol
@protocol BDRegisterCellProtocol <NSObject>

+ (void)registerNib:(id)aView;
+ (void)registerClass:(id)aView;

+ (id)getNibCell:(id)aView forIndexPath:(NSIndexPath *)indexPath;
+ (id)getClassCell:(id)aView forIndexPath:(NSIndexPath *)indexPath;

@end
#endif /* BDBaseProtocol_h */
