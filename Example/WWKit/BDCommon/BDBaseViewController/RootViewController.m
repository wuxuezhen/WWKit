//
//  RootViewController.m
//  WeiDu
//
//  Created by 吴振振 on 2017/11/16.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bd_setSuperNavnavigation];
}

//#pragma mark - 隐藏导航栏 shadow image
//-(BOOL)jm_hiddenNavShadowImage{
//    return YES;
//}
//
//-(void)findHiddenShadowImage{
//    UIImageView *iv = [self findShadowImage:self.navigationController.navigationBar];
//    iv.hidden = [self jm_hiddenNavShadowImage];
//}
//
//-(UIImageView *)findShadowImage:(UIView *)aView{
//    if ([aView isKindOfClass:[UIImageView class]] && aView.bounds.size.height <= 1) {
//        return (UIImageView *)aView;
//    }
//    for (UIView *view in aView.subviews) {
//        UIImageView *iv =  (UIImageView *)[self findShadowImage:view];
//        if (iv) {
//            return iv;
//        }
//    }
//    return  nil;
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.tableView == scrollView) {
//        if (scrollView.contentOffset.y > 200) {
//            CGFloat alpha = (scrollView.contentOffset.y - 200) / 64;
//            if (alpha <= 1) {
//                [self jm_setNavigationBarWithAlpha:alpha];
//            }
//        }else{
//            [self jm_setNavigationBarWithAlpha:0.0];
//        }
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
