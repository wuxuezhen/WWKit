//
//  BDNetAPI.h
//
//  Created by wzz on 2018/8/28.
//  Copyright © 2018年 wzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDNetRequst.h"

typedef void (^SuccessHandler)(id _Nullable responseObject);
typedef void (^FailureHandler)(NSError *_Nonnull error);

@interface BDNetAPI : NSObject

#pragma mark - 需要传入请求参数(FITNetRequst)

/**
 通用请求

 @param bdRequst 请求参数 注：需要配置 链接：path，请求方式：requestMethod, 解析方式：parseMethod ，条件参数：parameters ，解析类：responseModel（解析方式部位no时，必传字段）;
 @param success 成功回调
 @param failure 失败回调
 @return task
 */
+ (NSURLSessionDataTask *_Nonnull)BDRequst:(BDNetRequst *_Nonnull)bdRequst
                                    success:(SuccessHandler _Nullable )success
                                    failure:(FailureHandler _Nullable )failure;


@end
