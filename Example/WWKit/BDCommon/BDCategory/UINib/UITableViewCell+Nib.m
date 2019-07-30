//
//  UITableViewCell+Nib.m
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "UITableViewCell+Nib.h"

@implementation UITableViewCell (Nib)

#pragma mark - BDNibProtocol
+ (UINib *)nib {
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
}

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

#pragma mark - BDRegisterCellProtocol
+ (void)registerNib:(id)aView {
     [(UITableView *)aView registerNib:[self nib] forCellReuseIdentifier:[self reuseIdentifier]];
}

+ (void)registerClass:(id)aView {
     [(UITableView *)aView registerClass:[self class] forCellReuseIdentifier:[self reuseIdentifier]];
}

+ (id)getNibCell:(id)aView forIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [self reuseIdentifier];
    UITableViewCell *cell = [(UITableView *)aView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:nil options:nil] lastObject];
    }
    return cell;
}

+ (id)getClassCell:(id)aView forIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self reuseIdentifier];
    UITableViewCell *cell = [(UITableView *)aView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[self class] alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
