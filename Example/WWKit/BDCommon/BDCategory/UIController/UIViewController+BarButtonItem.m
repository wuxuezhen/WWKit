//
//  UIViewController+BarButtonItem.m
//
//  Created by caiyi on 2018/8/27.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "UIViewController+BarButtonItem.h"

@implementation UIViewController (BarButtonItem)

#pragma mark - 设置父类导航
-(void)bd_setSuperNavnavigation{
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.count>1) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]init];
        self.navigationItem.backBarButtonItem.title = @"返回";
        //        self.navigationItem.leftItemsSupplementBackButton = YES;
        //        self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"backImageName"];
        //        self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"backImageName"];
    }
}



#pragma mark - barButtonItem left && right

- (void)bd_createRightBarButtonItemWithImage:(NSString *)imageName{
    NSAssert(imageName.length>0,@"图片名称不能为空");
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItemWithImage:imageName];
}

- (void)bd_createRightBarButtonItemWithTitle:(NSString *)title{
    NSAssert(title.length>0,@"title 不能为空");
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItemWithTitle:title];
}

- (void)bd_createLeftBarButtonItemWithImage:(NSString *)imageName{
    NSAssert(imageName.length>0,@"图片名称不能为空");
    self.navigationItem.leftBarButtonItem = [self leftBarButtonItemWithImage:imageName];
}

- (void)bd_createLeftBarButtonItemWithTitle:(NSString *)title{
    NSAssert(title.length>0,@"title 不能为空");
    self.navigationItem.leftBarButtonItem = [self leftBarButtonItemWithTitle:title];
}


- (UIBarButtonItem *)leftBarButtonItemWithImage:(NSString *)imageName{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(bd_leftBarButtonItemAction:)];
    return barButtonItem;
    
}
- (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(bd_leftBarButtonItemAction:)];
    return barButtonItem;
}

- (UIBarButtonItem *)rightBarButtonItemWithImage:(NSString *)imageName{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(bd_rightBarButtonItemAction:)];
    return barButtonItem;
    
}

- (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(bd_rightBarButtonItemAction:)];
    return barButtonItem;
}

- (void)bd_rightBarButtonItemAction:(UIBarButtonItem *)barButtonItem{
    
}

- (void)bd_leftBarButtonItemAction:(UIBarButtonItem *)barButtonItem{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bd_navigationTitleColor:(UIColor *)titleColor{
     self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
}

-(void)bd_statusBarStyle:(UIStatusBarStyle)statusBarStyle{
    [UIApplication sharedApplication].statusBarStyle = statusBarStyle;
}
@end
