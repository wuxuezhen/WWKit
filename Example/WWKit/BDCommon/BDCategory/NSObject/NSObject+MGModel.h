//
//  NSObject+MGModel.h
//  MGTools
//
//  Created by Alfred Zhang on 2018/2/28.
//  Copyright © 2018年 MIGU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (MGModel)

- (BOOL)mg_boolValue;

- (NSInteger)mg_integerValue;

- (CGFloat)mg_floatValue;

@property (nonatomic, strong) id mgOriginData;

@end
