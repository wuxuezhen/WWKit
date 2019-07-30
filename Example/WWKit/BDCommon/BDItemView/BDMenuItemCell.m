//
//  BDMenuItemCell.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/4/26.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDMenuItemCell.h"
@interface BDMenuItemCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *coverView;

@end
@implementation BDMenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

-(void)setSelectItem:(BOOL)selectItem{
    _selectItem = selectItem;
    if (self.coverStyle) {
        self.coverView.hidden = !selectItem;
    }else{
        self.coverView.hidden = YES;
    }
    
    if (selectItem) {
        self.titleLabel.textColor =  self.coverStyle ? BD_RGB_HEX(0xFFFFFF) : BD_RGB_HEX(0xFF7144);
    }else{
        self.titleLabel.textColor = BD_RGB_HEX(0x999999);
    }
}

@end
