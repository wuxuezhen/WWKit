//
//  BDNetRequst.h
//  FitBody
//
//  Created by caiyi on 2018/8/28.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDAPI.h"
#import "BDConstants.h"

//typedef void (^RequstSuccessHandler)(id _Nullable responseObject);
//typedef void (^RequstFailureHandler)(NSError *_Nonnull error);

typedef NS_ENUM(NSInteger, BDParseMethod) {
    BDParseMethodObject     =  0,
    BDNOParseMethodObject,
    BDParseMethodList,
    BDNOParseMethodList,
    BDParseMethodObjectWithKey,
    BDParseMethodListWithKey
};

@interface BDNetRequst : NSObject

-(instancetype) initWithPath:(NSString *)path
               requestMethod:(BDAPIMethod)requestMethod
                 parseMethod:(BDParseMethod)parseMethod
                  parameters:(id)parameters
               responseModel:(Class)responsModel;


//#pragma mark - 需要传入请求参数(FITNetRequst)
//
///**
// 通用请求
// 注：需要配置 链接：path，请求方式：requestMethod, 解析方式：parseMethod ，条件参数：parameters ，解析类：responseModel（解析方式部位no时，必传字段）;
// @param success 成功回调
// @param failure 失败回调
// @return task
// */
//-(NSURLSessionDataTask *_Nonnull)bd_requstSuccess:(RequstSuccessHandler _Nullable )success
//                                          failure:(RequstFailureHandler _Nullable )failure;
//

/**
 baseUrl
 */
@property (nonatomic, copy) NSString  *baseUrl;

/**
 接口路径
 */
@property (nonatomic, copy) NSString *path;

/**
 请求路径
 */
@property (nonatomic, copy) NSString *requestUrl;

/**
 请求方式
 */
@property (nonatomic, assign) BDAPIMethod requestMethod;


/**
 解析方式
 */
@property (nonatomic, assign) BDParseMethod parseMethod;

/**
 解析路径
 */
@property (nonatomic, copy) NSString *parseKey;

/**
 参数
 */
@property (nonatomic, strong) id parameters;


/**
 解析结果 类
 */
@property (nonatomic, strong) Class  responseModel;

@property (nonatomic, strong) NSDate *resquestDate;

@property (nonatomic, assign) BDRequestSerializer serializer;

@end
