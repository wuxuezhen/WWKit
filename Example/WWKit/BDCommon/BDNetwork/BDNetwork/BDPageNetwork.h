//
//  BDPageNetwork.h
//  FitBody
//
//  Created by caiyi on 2018/8/21.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDConstants.h"
@interface BDPageNetwork : NSObject
@property (nonatomic, readonly) NSInteger currentPage;
@property (nonatomic, readonly) NSInteger totalPage;
@property (nonatomic, readonly) BOOL allDownloaded;
@property (nonatomic, readonly) BOOL networkFailed;
@property (nonatomic, readonly, getter=isLoading) BOOL loading;

@property (nonatomic, copy) void (^NextPageHandler)(NSArray *results,BOOL isAllLoaded);
@property (nonatomic, copy) void (^NetworkingErrorHandler)(NSError *error ,NSString *message);
@property (nonatomic, copy) void (^RefreshHandler)(void);
@property (nonatomic, copy) void (^AllLoadedHandler)(void);
@property (nonatomic, copy) void (^AllTotalCount)(NSInteger total);

- (void)getNextPage;
- (void)getFirstPage;
- (void)refreshParams:(NSDictionary *)params;
- (void)refreshParams:(NSDictionary *)params withCompletion:(void (^)(void))completion;

- (instancetype)initWithJSONModelClass:(Class)klass key:(NSString *)key apiPath:(NSString *)path;
- (instancetype)initWithJSONModelClass:(Class)klass key:(NSString *)key apiPath:(NSString *)path params:(NSDictionary *)params;
@end
