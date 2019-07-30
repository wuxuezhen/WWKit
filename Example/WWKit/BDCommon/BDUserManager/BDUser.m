//
//  BDUser.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/2/21.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDUser.h"

@implementation BDMenuTree

@end

@implementation BDUser

-(NSString *)username{
    return self.phone;
}

-(BDMenuTree *)business{
    return [self getTreeWithFid:@"1001"];
}

-(BDMenuTree *)operate{
    return [self getTreeWithFid:@"1002"];
}

-(BDMenuTree *)special{
    return [self getTreeWithFid:@"1003"];
}

-(BDMenuTree *)monitor{
    return [self getTreeWithFid:@"1004"];
}

-(BDMenuTree *)quality{
    return [self getTreeWithFid:@"1005"];
}

-(BDMenuTree *)getTreeWithFid:(NSString *)fid{
    return [BDUser getCurrentTreeWithDatas:self.children forFid:fid];
}

+(BDMenuTree *)getCurrentTreeWithDatas:(NSArray *)datas forFid:(NSString *)fid{
    BDMenuTree *tree = nil;
    for (BDMenuTree *obj in datas) {
        if ([obj.menuNo isEqualToString:fid]) {
            tree = obj;
            break;
        }
    }
    return tree;
}

+(NSArray *)bd_menuNos:(NSArray *)datas{
    NSMutableArray *menuNos = [NSMutableArray arrayWithCapacity:0];
    for (BDMenuTree *tree in datas) {
        [menuNos addObject:tree.menuNo];
    }
    return menuNos;
}

+(NSArray *)bd_menuNames:(NSArray *)datas{
    NSMutableArray *menuNames = [NSMutableArray arrayWithCapacity:0];
    for (BDMenuTree *tree in datas) {
        [menuNames addObject:tree.menuName];
    }
    return menuNames;
}

@end
