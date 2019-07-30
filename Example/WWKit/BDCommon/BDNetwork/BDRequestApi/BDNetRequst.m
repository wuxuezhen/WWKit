//
//  BDNetRequst.m
//  FitBody
//
//  Created by caiyi on 2018/8/28.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "BDNetRequst.h"
#import <JSONModel/JSONModel.h>
@implementation BDNetRequst

-(instancetype)init{
    if (self = [super init]) {
        _requestUrl    = [self.baseUrl stringByAppendingString:self.path ? : @""];
        _requestMethod = self.requestMethod;
        _parseMethod   = self.parseMethod;
        _responseModel = self.responseModel;
    }
    return self;
}

-(instancetype)initWithPath:(NSString *)path
              requestMethod:(BDAPIMethod)requestMethod
                parseMethod:(BDParseMethod)parseMethod
                 parameters:(id)parameters
              responseModel:(__unsafe_unretained Class)responsModel{
    if (self = [super init]) {
        _requestUrl    = [self.baseUrl stringByAppendingString:path];
        _requestMethod = requestMethod;
        _parseMethod   = parseMethod;
        _responseModel = responsModel;
        
        if (parameters && [parameters isKindOfClass: JSONModel.class]) {
            _parameters = [(JSONModel *)parameters toDictionary];
        }else{
            _parameters = parameters;
        }
    }
    return self;
}

//#pragma mark - 需要传入请求方式请求方式
//-(NSURLSessionDataTask *)bd_requstSuccess:(RequstSuccessHandler)success
//                                  failure:(RequstFailureHandler)failure{
//
//    switch (self.parseMethod) {
//        case BDParseMethodObject:
//            return [BDAPI requestWithMethod:self.requestMethod
//                                       path:self.path
//                                     params:self.parameters
//                            parseIntoAClass:self.responseModel
//                                    success:success
//                                    failure:failure];
//            break;
//
//        case BDParseMethodList:
//            return [BDAPI requestWithMethod:self.requestMethod
//                                       path:self.path
//                                     params:self.parameters
//                      parseIntoArrayOfClass:self.responseModel
//                                    success:success
//                                    failure:failure];
//            break;
//
//        case BDParseMethodObjectWithKey:
//            return [BDAPI requestWithMethod:self.requestMethod
//                                       path:self.path
//                                     params:self.parameters
//                            parseIntoAClass:self.responseModel
//                                    withKey:self.parseKey
//                                    success:success
//                                    failure:failure];
//            break;
//        case BDParseMethodListWithKey:
//            return [BDAPI requestWithMethod:self.requestMethod
//                                       path:self.path
//                                     params:self.parameters
//                      parseIntoArrayOfClass:self.responseModel
//                                    withKey:self.parseKey
//                                    success:success
//                                    failure:failure];
//            break;
//
//
//        default:
//            return [BDAPI requestWithMethod:self.requestMethod
//                                       path:self.path
//                                     params:self.parameters
//                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                                        success ? success(responseObject) : nil;
//                                    } failure:failure];
//            break;
//    }
//}
//

-(id)parameters{
    return (_parameters && [_parameters isKindOfClass: JSONModel.class]) ? [(JSONModel *)_parameters toDictionary] :_parameters;
}

-(NSString *)baseUrl {
    return BD_BASEURL;
}
@end
