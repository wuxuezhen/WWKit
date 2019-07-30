//
//  UIViewController+Alert.m
//  bdBody
//
//  Created by caiyi on 2018/8/29.
//  Copyright © 2018年 caiyi. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                confirmAction:(void (^)(void))confirmAciton
                 cancelAction:(void (^)(void))cancelAciton {
    
    [self bd_showAlertWithTitle:title
                        message:message
         destructiveActionTitle:@"确定"
              cancelActionTitle:@"取消"
                  confirmAction:confirmAciton
                   cancelAction:cancelAciton];
}

- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
       destructiveActionTitle:(NSString *)destructiveTitle
            cancelActionTitle:(NSString *)cancelTitle
                confirmAction:(void (^)(void))confirmAciton
                 cancelAction:(void (^)(void))cancelAciton{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                  if (cancelAciton) {
                                                      cancelAciton();
                                                  }
                                              }]];
    [alert addAction:[UIAlertAction actionWithTitle:destructiveTitle
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                  if (confirmAciton) {
                                                      confirmAciton();
                                                  }
                                              }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}





- (void)bd_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                confirmAction:(void (^)(void))confirmAciton{
    
    [self bd_showAlertWithTitle:title
                        message:message
                    actionTitle:@"确定"
                  confirmAction:confirmAciton];
    
}

-(void)bd_showAlertWithTitle:(NSString *)title
                     message:(NSString *)message
                 actionTitle:(NSString *)actionTitle
               confirmAction:(void (^)(void))confirmAciton{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:actionTitle
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                  if (confirmAciton) {
                                                      confirmAciton();
                                                  }
                                              }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end

