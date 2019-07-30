//
//  BDMenuItemTextCell.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/7/1.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDMenuItemTextCell.h"
@interface BDMenuItemTextCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation BDMenuItemTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

@end
