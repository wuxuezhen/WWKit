//
//  BDUser.h
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/2/21.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDResponseModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BDMenuTree;
@interface BDMenuTree : BDResponseModel
@property (nonatomic, assign) NSInteger menuId;
@property (nonatomic, assign) NSInteger menuFId;
@property (nonatomic, copy) NSString *menuNo;
@property (nonatomic, copy) NSString *menuName;
@property (nonatomic, copy) NSString *menuNameT;
@property (nonatomic, copy) NSString *menuFN;
@property (nonatomic, copy) NSString *menuDes;

@property (nonatomic, strong) NSArray <BDMenuTree> *children;
@end

@interface BDUser : BDResponseModel
// 用户名
@property (nonatomic, copy) NSString *name;
// 密码
@property (nonatomic, copy) NSString *password;
// 省份
@property (nonatomic, copy) NSString *provinces;

// 用户名手机号
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *version;

@property (nonatomic, strong) NSArray <BDMenuTree> *children;

@property (nonatomic, strong) BDMenuTree *business;
@property (nonatomic, strong) BDMenuTree *operate;
@property (nonatomic, strong) BDMenuTree *special;
@property (nonatomic, strong) BDMenuTree *monitor;
@property (nonatomic, strong) BDMenuTree *quality;

+(BDMenuTree *)getCurrentTreeWithDatas:(NSArray *)datas forFid:(NSString *)fid;

+(NSArray *)bd_menuNos:(NSArray *)datas;

+(NSArray *)bd_menuNames:(NSArray *)datas;

@end

NS_ASSUME_NONNULL_END
