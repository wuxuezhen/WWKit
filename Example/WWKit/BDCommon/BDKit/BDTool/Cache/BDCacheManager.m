//
//  BDCacheManager.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2018/5/25.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import "BDCacheManager.h"
#import <WebKit/WebKit.h>
@implementation BDCacheManager


+ (void)bd_clearWebache{
    
//    NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
    NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
    NSSet *webTypes= [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,WKWebsiteDataTypeMemoryCache]];
    [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:webTypes modifiedSince:dateFrom completionHandler:^{
        
    }];
}


//清理缓存
+(void)bd_clearache{
    [self clearCacheAtPath:[self getPath]];
}

//计算缓存文件的大小
+(CGFloat)bd_cacheSize{
    return [self folderSizeWithPath:[self getPath]];
}


+ (CGFloat)folderSizeWithPath:(NSString *)path {
    NSFileManager * manager = [NSFileManager defaultManager];
    CGFloat folderSize = 0.0;
    if ([manager fileExistsAtPath:path]) {
        NSArray * fileArray = [manager subpathsAtPath:path];
        for (NSString * fileName in fileArray) {
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            long fileSize = [manager attributesOfItemAtPath:filePath error:nil].fileSize;
            folderSize += fileSize / 1024.0 / 1024.0;
        }
        return folderSize;
    }else{
        return 0.0;
    }
}


+ (void)clearCacheAtPath:(NSString *)path{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSArray * fileArray = [manager subpathsAtPath:path];
        for (NSString * fileName in fileArray) {
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            if ([manager fileExistsAtPath:filePath]) {
                [manager removeItemAtPath:filePath error:nil];
            }
        }
    }
}

+(NSString *)getPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
}

@end
