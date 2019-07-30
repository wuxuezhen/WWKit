//
//  BDJSONRequestSerializer.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/1/15.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDJSONRequestSerializer.h"
#import "BDDevice.h"
@implementation BDJSONRequestSerializer
-(instancetype) init {
    if (self = [super init]) {
        self.timeoutInterval = 60;
//        self.cachePolicy = NSURLRequestReturnCacheDataElseLoad;// 缓存
        [self setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self setValue:[BDDevice bd_appVersion] forHTTPHeaderField:@"X-Version"];
    }
    
    return self;
}
@end
