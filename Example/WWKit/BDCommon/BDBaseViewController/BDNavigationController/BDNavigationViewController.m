//
//  BDNavigationViewController.m
//  BDData
//
//  Created by 吴振振 on 2017/11/24.
//  Copyright © 2017年 吴振振. All rights reserved.
//

#import "BDNavigationViewController.h"
#import "UIColor+BDColor.h"
#import "RootViewController.h"

@interface BDNavigationViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BDNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
    // Do any additional setup after loading the view.
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
//        self.navigationBar.tintColor = [UIColor blackColor];
//        self.navigationBar.barTintColor = [UIColor jm_themeColor];
    }
    return self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   if (self.childViewControllers.count > 0){
       viewController.hidesBottomBarWhenPushed = YES;
       UIImage *image = [UIImage imageNamed:@"bd_nav_back"];
       UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:image
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(bd_navBackAction)];
       viewController.navigationItem.leftBarButtonItem = leftItem;
   }
    [super pushViewController:viewController animated:animated];
}

-(void)bd_navBackAction{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.childViewControllers.count > 1;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if ([viewController isKindOfClass:RootViewController.class]) {
        RootViewController *root = (RootViewController *)viewController;
        if ([root respondsToSelector:@selector(wz_banPopGestureRecognizerEnable)] && root.wz_banPopGestureRecognizerEnable) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
            navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    }
    
    
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
        navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
