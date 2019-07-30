//
//  BDNetAPI.m
//
//  Created by caiyi on 2018/8/28.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "BDNetAPI.h"

@implementation BDNetAPI

#pragma mark - 需要传入请求方式请求方式
+ (NSURLSessionDataTask *)BDRequst:(BDNetRequst *)bdRequst success:(SuccessHandler)success failure:(FailureHandler)failure{
    [BDAPI bd_setRequestSerializer:bdRequst.serializer];
    switch (bdRequst.parseMethod) {
        case BDParseMethodObject:
            return [BDAPI requestWithMethod:bdRequst.requestMethod
                                        path:bdRequst.requestUrl
                                      params:bdRequst.parameters
                             parseIntoAClass:bdRequst.responseModel
                                     success:success
                                     failure:failure];
            break;
            
        case BDParseMethodList:
            return [BDAPI requestWithMethod:bdRequst.requestMethod
                                        path:bdRequst.requestUrl
                                      params:bdRequst.parameters
                       parseIntoArrayOfClass:bdRequst.responseModel
                                     success:success
                                     failure:failure];
            break;
            
        case BDParseMethodObjectWithKey:
            return [BDAPI requestWithMethod:bdRequst.requestMethod
                                       path:bdRequst.requestUrl
                                     params:bdRequst.parameters
                            parseIntoAClass:bdRequst.responseModel
                                    withKey:bdRequst.parseKey
                                    success:success
                                    failure:failure];
            break;
        case BDParseMethodListWithKey:
            return [BDAPI requestWithMethod:bdRequst.requestMethod
                                       path:bdRequst.requestUrl
                                     params:bdRequst.parameters
                      parseIntoArrayOfClass:bdRequst.responseModel
                                    withKey:bdRequst.parseKey
                                    success:success
                                    failure:failure];
            break;
            
            
        default:
            return [BDAPI requestWithMethod:bdRequst.requestMethod
                                       path:bdRequst.requestUrl
                                     params:bdRequst.parameters
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                             success ? success(responseObject) : nil;
                                        });
                                    } failure:failure];
            break;
    }
}

@end
