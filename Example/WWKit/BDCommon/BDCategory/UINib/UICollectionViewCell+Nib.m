//
//  UICollectionViewCell+Nib.m
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "UICollectionViewCell+Nib.h"

@implementation UICollectionViewCell (Nib)

#pragma mark - BDNibProtocol
+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - BDRegisterCellProtocol
+ (void)registerNib:(id)aView {
    [(UICollectionView *)aView registerNib:[self nib] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

+ (void)registerClass:(id)aView {
    [(UICollectionView *)aView registerClass:[self class] forCellWithReuseIdentifier:[self reuseIdentifier]];
}

+ (id)getNibCell:(id)aView forIndexPath:(NSIndexPath *)indexPath{
    return [self getClassCell:aView forIndexPath:indexPath];
}

+ (id)getClassCell:(id)aView forIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self reuseIdentifier];
    return [(UICollectionView *)aView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
