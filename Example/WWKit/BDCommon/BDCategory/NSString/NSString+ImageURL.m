//
//  NSString+ImageURL.m
//  AZURestWeidu3
//
//  Created by 吴振振 on 2018/1/24.
//  Copyright © 2018年 coreface. All rights reserved.
//

#import "NSString+ImageURL.h"

static NSString *AliPrefix = @"http://images.weidu.xin/";

@implementation NSString (ImageURL)

-(NSString *)jm_imageURLFor200{
    if ([self hasPrefix:AliPrefix]){
        return [self jm_imageURLForSizeW:200];
    }else{
       return self;
    }
}

-(NSString *)jm_imageURLFor400{
    if ([self hasPrefix:AliPrefix]){
        return [self jm_imageURLForSizeW:400];
    }else{
        return self;
    }
}

-(NSString *)jm_imageURLFor500{
    if ([self hasPrefix:AliPrefix]){
        return [self jm_imageURLForSizeW:500];
    }else{
        return self;
    }
}

-(NSString *)jm_imageURLFor800{
    if ([self hasPrefix:AliPrefix]){
        return [self jm_imageURLForSizeW:800];
    }else{
        return self;
    }
}

-(NSString *)jm_imageURLForSizeW:(NSInteger)width{
    NSString *suffix = [NSString stringWithFormat:@"?x-oss-process=image/resize,m_lfit,w_%@/quality,Q_60",@(width)];
    return [self stringByAppendingString:suffix];
}

@end
