//
//  BDResponseSerializer.m
//
//  Created by caiyi on 2018/8/21.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "BDResponseSerializer.h"
#import "BDConstants.h"

@implementation BDResponseSerializer

- (instancetype)init {
    if (self = [super init]) {
        NSMutableSet *acceptSet = [self.acceptableContentTypes mutableCopy];
        [acceptSet addObject:@"text/plain"];
        [acceptSet addObject:@"text/javascript"];
        [acceptSet addObject:@"text/html"];
        [acceptSet addObject:@"text/css"];
        [acceptSet addObject:@"text/xml"];
        [acceptSet addObject:@"text/json"];
        [acceptSet addObject:@"text/html;charset=utf-8"];
        [acceptSet addObject:@"application/json"];
        [acceptSet addObject:@"application/javascript"];
        [acceptSet addObject:@"application/x-javascript"];
        [acceptSet addObject:@"application/x-gzip"];
        [acceptSet addObject:@"image/*"];
        self.acceptableContentTypes = [acceptSet copy];
    }
    return self;
}

- (id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing  _Nullable *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    });
    
//    NSHTTPURLResponse * responses = (NSHTTPURLResponse *)response;
    id result = [super responseObjectForResponse:response data:data error:error];
    BOOL success   = [result[BDSuccess] boolValue];
    BOOL success2  = [self isObject:result[BDResult]] ? NO : [result[BDResult] boolValue];
    NSInteger code = [result[BDCode] integerValue];

    if (success2 && result[BDDatas]) {
        return result[BDDatas];
    }else if (result[BDDatas] && [self isObject:result[BDDatas]]){
        return result[BDDatas];
    }else if ([result[BDResultDesc] isEqualToString:@"ok!"]){
        return result[BDDatas];
    }
    
    if (result && !success) {
        
        if ([result isKindOfClass:NSDictionary.class]) {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:result];
            NSString *errorMsg = result[BDMessage] ? :[self errorMessageWithRequest:code];
            if (errorMsg && errorMsg.length > 200) {
                errorMsg = @"服务器异常";
            }
            NSString *errorDescription   = errorMsg;
            userInfo[BDMETAERRORMSGKEY]  = errorDescription ? : (result[BDResultDesc] ? :result[BDException]);
            userInfo[BDMETAERRORCODEKEY] = @(code);
//            userInfo[BDMETARESPONSECODEKEY] = @(responses.statusCode);
            *error = [NSError errorWithDomain:BDMETAERRORDOMIN
                                         code:code
                                     userInfo:userInfo];
        }
        
        if (result[@"datas"]) {
            return result[@"datas"];
        }
    }
    return result[BDResult];
}

-(NSString *)errorMessageWithRequest:(NSInteger)code{
    NSString *message = nil;
    switch (code) {
        case 400:
            message = @"请求失败";
            break;
        case 500:
            message = @"请求失败";
            break;
        case 403:
            message = @"非法的请求";
            break;
        case 498:
            message = @"token失效";
            break;
        default:
            
            break;
    }
    return message;
}

-(BOOL)isObject:(id)obj{
    return [obj isKindOfClass: NSDictionary.class] || [obj isKindOfClass: NSDictionary.class];
}

@end
