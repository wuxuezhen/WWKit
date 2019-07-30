//
//  BDAPI.m
//
//  Created by wzz on 2018/8/21.
//  Copyright © 2018年 wzz. All rights reserved.
//

#import "BDAPI.h"

#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>

#import "BDResponseSerializer.h"
#import "BDJSONRequestSerializer.h"
#import "BDConstants.h"
#import "NSObject+Object.h"

@implementation BDAPI

/**
 请求单例
 
 @return 单例对象
 */
+ (AFHTTPSessionManager *)sharedAPI {
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]init];
        manager.requestSerializer  = [BDJSONRequestSerializer serializer];
        manager.responseSerializer = [BDResponseSerializer serializer];
        manager.operationQueue.maxConcurrentOperationCount = 15;
        manager.completionQueue = dispatch_queue_create("com.miguEye.api", DISPATCH_QUEUE_CONCURRENT);
        
    });
    
    //    NSString  * dateStr = TrainTimerCurrentTime();
    //    [manager.requestSerializer setValue:dateStr forHTTPHeaderField:@"X-Time"];
    //    [manager.requestSerializer setValue:[self token] forHTTPHeaderField:@"X-Token"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    return manager;
}

+(void)bd_setRequestSerializer:(BDRequestSerializer)serializer{
    if (serializer == BDRequestSerializerJson) {
         [self sharedAPI].requestSerializer = [BDJSONRequestSerializer serializer];
    }else{
         [self sharedAPI].requestSerializer = [AFHTTPRequestSerializer serializer];
    }
}

/**
 获取token
 
 @return token令牌
 */
//+(NSString *)token{
//    return [FITGeneralDataCache sharedFITGeneralDataCache].authToken;
//}

#pragma mark - 证书设置
//+(AFSecurityPolicy*)customSecurityPolicy {
//
//    NSArray *cerPaths = @[@"tryfits.com",@"_.shanghaicaiyi"];
//    NSMutableArray *cers = [NSMutableArray arrayWithCapacity:cerPaths.count];
//    for (NSString *path in cerPaths) {
//        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"cer"]];
//        [cers addObject:data];
//    }
//    // AFSSLPinningModeCertificate 使用证书验证模式
//    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    securityPolicy.allowInvalidCertificates = NO;
//    securityPolicy.validatesDomainName = YES;
//    securityPolicy.pinnedCertificates = [[NSSet alloc]initWithArray:cers];
//    
//    return securityPolicy;
//    
//}
#pragma mark - ******************************************** 分割线  *****************************************************
#pragma mark - GET、POST、PUT、DELETE 四请求方式

+ (NSURLSessionDataTask *)GET:(NSString *)path
                       params:(NSDictionary *)params
                      success:(void (^ _Nullable)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))success
                      failure:(void (^ _Nullable)(NSError *_Nonnull error))failure {
    return [[self sharedAPI] GET:path
                      parameters:params
                        progress:nil
                         success:success
                         failure:^(NSURLSessionDataTask *task, NSError *error) {
                             [self executeFailure:failure withError:error];
                         }];
}


+ (NSURLSessionDataTask *)POST:(NSString *)path
                        params:(NSDictionary *)params
                       success:(void (^ _Nullable)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))success
                       failure:(void (^ _Nullable)(NSError *_Nonnull error))failure {
    return [[self sharedAPI] POST:path
                       parameters:params
                         progress:nil
                          success:success
                          failure:^(NSURLSessionDataTask *task, NSError *error) {
                              [self executeFailure:failure withError:error];
                          }];
}


+ (NSURLSessionDataTask *)PUT:(NSString *)path
                       params:(NSDictionary *)params
                      success:(void (^ _Nullable)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))success
                      failure:(void (^ _Nullable)(NSError *_Nonnull error))failure {
    return [[self sharedAPI] PUT:path
                      parameters:params
                         success:success
                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             [self executeFailure:failure withError:error];
                         }];
}


+ (NSURLSessionDataTask *)DELETE:(NSString *)path
                          params:(NSDictionary *)params
                         success:(void (^ _Nullable)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))success
                         failure:(void (^ _Nullable)(NSError *_Nonnull error))failure {
    return [[self sharedAPI] DELETE:path
                         parameters:params
                            success:success
                            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [self executeFailure:failure withError:error];
                            }];
}




#pragma mark - 根据请求方式调用请求接口 （不转数据模型）
+ (NSURLSessionDataTask *)requestWithMethod:(BDAPIMethod)method
                                       path:(NSString *)path
                                     params:(NSDictionary *)params
                                    success:(void (^ _Nullable)(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject))success
                                    failure:(void (^ _Nullable)(NSError *_Nonnull error))failure {
    switch (method) {
        case BDAPIMethodGet:
            return [self GET:path params:params success:success failure:failure];
            break;
        case BDAPIMethodPost:
            return [self POST:path params:params success:success failure:failure];
            break;
        case BDAPIMethodPut:
            return [self PUT:path params:params success:success failure:failure];
            break;
        case BDAPIMethodDelete:
            return [self DELETE:path params:params success:success failure:failure];
        default:
            break;
    }
}



#pragma mark - 根据请求方式调用请求接口 （转数据模型）

/**
 数组不带key请求
 
 @param method 请求方式
 @param path 路径
 @param params 参数
 @param klass 数据模型
 @param success 成功回调 数组
 @param failure 失败回调
 @return task
 */
+ (NSURLSessionDataTask *)requestWithMethod:(BDAPIMethod)method
                                       path:(NSString *)path
                                     params:(NSDictionary *)params
                      parseIntoArrayOfClass:(Class)klass
                                    success:(void (^ _Nullable)(NSArray * _Nullable))success
                                    failure:(void (^ _Nullable)(NSError * _Nonnull))failure{
    return [self requestWithMethod:method
                              path:path
                            params:params
                           success:^(NSURLSessionDataTask *task, id responseObject) {
                               
                               if ([responseObject isKindOfClass:NSArray.class]) {
                                   NSArray *results = [self parseIntoArrayOfClass:klass fromArray:responseObject];
                                   [self exectuteSuccess:success withResults:results];
                               } else {
                                   [self exectuteSuccess:success withResults:@[]];
                               }
                           }
                           failure:failure];
}



/**
 数组带key请求
 @param method 请求方式
 @param path 路径
 @param params 参数
 @param klass 数据模型
 @param key 解析字段名称
 @param success 成功回调 数组
 @param failure 失败回调
 @return task
 */
+ (NSURLSessionDataTask *)requestWithMethod:(BDAPIMethod)method
                                       path:(NSString *)path
                                     params:(NSDictionary *)params
                      parseIntoArrayOfClass:(Class)klass
                                    withKey:(NSString *)key
                                    success:(void (^ _Nullable)(NSArray * _Nullable))success
                                    failure:(void (^ _Nullable)(NSError * _Nonnull))failure{
    return [self requestWithMethod:method
                              path:path
                            params:params
                           success:^(NSURLSessionDataTask *task, id responseObject) {
                               NSDictionary *data = (NSDictionary *) responseObject;
                               if ([data isKindOfClass:NSDictionary.class]) {
                                   id object = [data jsonValueForKeyPath:key];
                                   if (key && [object isKindOfClass:NSArray.class]) {
                                       NSArray *results = [self parseIntoArrayOfClass:klass fromArray:object];
                                       [self exectuteSuccess:success withResults:results];
                                   } else {
                                       [self exectuteSuccess:success withResults:@[]];
                                   }
                                   
                               } else {
                                   [self exectuteSuccess:success withResults:@[]];
                               }
                           }
                           failure:failure];
}



/**
 对象不带key请求
 @param method 请求方式
 @param path 路径
 @param params 参数
 @param klass 数据模型
 @param success 成功回调 对象
 @param failure 失败回调
 @return task
 */
+ (NSURLSessionDataTask *)requestWithMethod:(BDAPIMethod)method
                                       path:(NSString *)path
                                     params:(NSDictionary *)params
                            parseIntoAClass:(Class)klass
                                    success:(void (^ _Nullable)(id))success
                                    failure:(void (^ _Nullable)(NSError *_Nonnull error))failure {
    return [self requestWithMethod:method path:path params:params
                           success:^(NSURLSessionDataTask *task, id responseObject) {
                               NSDictionary *data = (NSDictionary *) responseObject;
                               if ([data isKindOfClass:NSDictionary.class]) {
                                   
                                   id result = [self parseIntoAClass:klass fromDict:data];
                                   bd_dispatch_main_queue(^{
                                       success ? success(result) : nil;
                                   });
                               } else {
                                   bd_dispatch_main_queue(^{
                                       success ? success(nil) : nil;
                                   });
                               }
                           }
                           failure:failure];
}


/**
 对象带key请求
 @param method 请求方式
 @param path 路径
 @param params 参数
 @param klass 数据模型
 @param key 解析字段名称
 @param success 成功回调 数组
 @param failure 失败回调
 @return task
 */
+ (NSURLSessionDataTask *)requestWithMethod:(BDAPIMethod)method
                                       path:(NSString *)path
                                     params:(NSDictionary *)params
                            parseIntoAClass:(Class)klass
                                    withKey:(NSString *)key
                                    success:(void (^ _Nullable)(id _Nullable))success
                                    failure:(void (^ _Nullable)(NSError * _Nonnull))failure {
    return [self requestWithMethod:method
                              path:path
                            params:params
                           success:^(NSURLSessionDataTask *task, id responseObject) {
                               NSDictionary *data = (NSDictionary *) responseObject;
                               if (key && [data isKindOfClass:NSDictionary.class]) {
                                   id object = [data jsonValueForKeyPath:key];
                                   if ([object isKindOfClass:[NSDictionary class]]) {
                                       id result = [self parseIntoAClass:klass fromDict:object];
                                       bd_dispatch_main_queue(^{
                                           success ? success(result) : nil;
                                       });
                                   } else {
                                       bd_dispatch_main_queue(^{
                                           success ? success(nil) : nil;
                                       });
                                   }
                               } else {
                                   bd_dispatch_main_queue(^{
                                       success ? success(nil) : nil;
                                   });
                               }
                           }
                           failure:failure];
}


#pragma mark - ******************************************** 分割线  *****************************************************
#pragma mark - 数据转型
/**
 数据转型 数组
 
 @param klass 数据模型
 @param dictArr 源数据
 @return 转型后数组
 */
+ (NSArray *)parseIntoArrayOfClass:(Class)klass fromArray:(NSArray *)dictArr {
    if ([klass isSubclassOfClass:[JSONModel class]]) {
        if (!dictArr) {
            return @[];
        }
        
        __block NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:dictArr.count];
        [dictArr enumerateObjectsUsingBlock:^(id _Nonnull dictionary, NSUInteger idx, BOOL *_Nonnull stop) {
            [array addObject:[[klass alloc] initWithDictionary:dictionary error:nil]];
        }];
        return array;
    }
    
    return @[];
}


/**
 数据转型 对象
 
 @param klass 数据模型
 @param dict 字典
 @return 转型后对象
 */
+ (nullable id)parseIntoAClass:(Class)klass fromDict:(NSDictionary *)dict {
    if (!dict) {
        return nil;
    }
    if ([klass isSubclassOfClass:[JSONModel class]]) {
        return [[klass alloc] initWithDictionary:dict error:nil];
    }
    
    return nil;
}


/**
 成功回调
 
 @param success 成功
 @param results 请求得到的数据
 */
+ (void)exectuteSuccess:(void (^ _Nullable)(NSArray *results))success withResults:(NSArray *)results {
    dispatch_async(dispatch_get_main_queue(), ^{
        success ? success(results) : nil;
    });
}


/**
 失败处理
 
 @param failure 失败
 @param error 错误信息
 */
+ (void)executeFailure:(void (^ _Nullable)(NSError *_Nonnull error))failure withError:(NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithDictionary:error.userInfo];
    if (!userInfo[BDMETAERRORMSGKEY]) {
        userInfo[BDMETAERRORMSGKEY] = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
    }
    
    if (!userInfo[BDMETAERRORMSGKEY]) {
        userInfo[BDMETAERRORMSGKEY] = [userInfo objectForKey:NSDebugDescriptionErrorKey];
    }
    
    if (error.code == 400) {
        //        token失效 账号过期统一处理
    } else {
        NSError *errorr = [NSError errorWithDomain:BDMETAERRORDOMIN
                                              code:error.code
                                          userInfo:userInfo];
        bd_dispatch_main_queue(^{
            failure ? failure(errorr) : nil;
        });
    }
    
}

#pragma mark - 线程处理
void bd_dispatch_main_queue(dispatch_block_t block) {
    bd_dispatch_on_queue(dispatch_get_main_queue(), block);
}

void bd_dispatch_on_queue(dispatch_queue_t queue, dispatch_block_t block) {
    dispatch_async(queue, block);
}

@end
