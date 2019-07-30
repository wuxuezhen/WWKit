//
//  BDPageNetwork.m
//  FitBody
//
//  Created by caiyi on 2018/8/21.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "BDPageNetwork.h"
#import "BDAPI.h"

@interface BDPageNetwork()
@property (nonatomic, readwrite) NSInteger currentPage;
@property (nonatomic, readwrite) NSInteger totalPage;
@property (nonatomic, readwrite) NSInteger totalCount;
@property (nonatomic, readwrite) BOOL allDownloaded;
@property (nonatomic, readwrite) BOOL networkFailed;
@property (nonatomic, readwrite, getter=isLoading) BOOL loading;
@property (strong, nonatomic) NSURLSessionDataTask *currentDataTask;

@property (strong, nonatomic) Class klass;
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *key;
@property (copy, nonatomic) NSDictionary *params;
@property (copy, nonatomic) void (^refreshCompletionBlock)(void);
@end

@implementation BDPageNetwork

- (instancetype)initWithJSONModelClass:(Class)klass key:(NSString *)key apiPath:(NSString *)path{
    if (self = [super init]) {
        _currentPage = 1;
        _klass = klass;
        _path = path;
        _key = key;
    }
    return self;
}

- (instancetype)initWithJSONModelClass:(Class)klass key:(NSString *)key apiPath:(NSString *)path params:(NSDictionary *)params {
    if (self = [self initWithJSONModelClass:klass key:key apiPath:path]) {
        _params = [params copy];
    }
    return self;
}


- (void)getFirstPage {
    self.RefreshHandler ? self.RefreshHandler() : nil;
    [self refreshState];
    [self getNextPage];
}

- (void)getNextPage {
    if (self.isLoading || self.allDownloaded) {
        if (self.allDownloaded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.AllLoadedHandler ? self.AllLoadedHandler() : nil;
            });
        }
        return ;
    }
    
    self.loading = YES;
    NSMutableDictionary *params = [@{
                                     @"pageNum" : @(self.currentPage),
                                     @"pageSize" : @20
                                     } mutableCopy];
    if (self.params) {
        [params addEntriesFromDictionary:self.params];
    }
    
    __weak typeof(self) wself = self;
    self.currentDataTask = [BDAPI GET:self.path params:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(self) strongSelf = wself;
        if (!strongSelf) {
            return ;
        }
        strongSelf.loading = NO;
        NSArray *results = [BDAPI parseIntoArrayOfClass:self.klass fromArray:responseObject[self.key ? : @"result"]];
        
        if (strongSelf.currentPage == strongSelf.totalPage || results.count < 20) {
            strongSelf.allDownloaded = YES;
        } else {
            strongSelf.allDownloaded = NO;
            strongSelf.currentPage++;
        }
      
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.NextPageHandler ? strongSelf.NextPageHandler(results,strongSelf.allDownloaded) : nil;
            [strongSelf refreshCompletion];
        });
        
        
    } failure:^(NSError * _Nonnull error) {
        __strong typeof(self) strongSelf = wself;
        if (!strongSelf) {
            return ;
        }
        strongSelf.loading = NO;
        strongSelf.allDownloaded = YES;
        strongSelf.networkFailed = YES;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.NetworkingErrorHandler ? strongSelf.NetworkingErrorHandler(error, [error.userInfo objectForKey:BDMETAERRORMSGKEY]) : nil;
            [strongSelf refreshCompletion];
        });
        
    }];
}


/**
 重置状态
 */
- (void)refreshState {
    self.allDownloaded = NO;
    self.loading = NO;
    self.currentPage = 1;
    [self cancelCurrentTask];
}


/**
 刷新请求

 @param params 参数
 */
- (void)refreshParams:(NSDictionary *)params {
    self.params = params;
    [self cancelCurrentTask];
    [self getFirstPage];
}

- (void)refreshParams:(NSDictionary *)params withCompletion:(void (^)(void))completion {
    self.refreshCompletionBlock = [completion copy];
    [self refreshParams:params];
}

-(void)refreshCompletion{
    self.refreshCompletionBlock ? self.refreshCompletionBlock() : nil;
    self.refreshCompletionBlock = nil;
}


/**
 取消请求
 */
- (void)cancelCurrentTask {
    if (self.currentDataTask  && self.currentDataTask.state == NSURLSessionTaskStateRunning) {
        [self.currentDataTask cancel];
    }
    self.currentDataTask = nil;
}
@end
