//
//  BDMenuItemCollectionViewCell.m
//  BusinessDataPlatform
//
//  Created by 吴振振 on 2019/6/13.
//  Copyright © 2019 donghui lv. All rights reserved.
//

#import "BDMenuItemCollectionViewCell.h"
@interface BDMenuItemCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation BDMenuItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bd_setTitle:(NSString *)title
         imageName:(NSString *)imageName{
    self.titleLabel.text = title;
    self.imageView.image = BD_ImageNamed(imageName);
}
@end
