//
//  UIViewController+LoadingHud.m
//  HNLandTax
//
//  Created by wzz on 2018/11/13.
//  Copyright © 2018 WYW. All rights reserved.
//

#import "UIViewController+LoadingHud.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>
#import "FITArcView.h"

@interface UIViewController ()
@property (nonatomic, strong) MBProgressHUD *loadingHUD;
@property (nonatomic, strong) FITArcView *arcView;
@end
@implementation UIViewController (LoadingHud)

- (void)wz_showProgressHud {
    [self wz_showProgressHud:nil];
}

-(void)wz_changeHudText:(NSString *)text{
    if (self.loadingHUD) {
        self.loadingHUD.label.text = text;
    }else{
        [self wz_showHubText:text];
    }
}

- (void)wz_showProgressHud:(NSString *)text{
    if (self.loadingHUD) {
        [self wz_dismissHud];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.loadingHUD    = hud;
    hud.mode           = MBProgressHUDModeCustomView;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.removeFromSuperViewOnHide = YES;
//    hud.bezelView.color = [UIColor clearColor];
//    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    FITArcView *arcview = [[FITArcView alloc]initWithFrame:CGRectZero];
    self.arcView   = arcview;
    hud.customView = self.arcView;
    NSLayoutConstraint *w_constraint = [NSLayoutConstraint constraintWithItem:arcview
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:37.f];
    NSLayoutConstraint *h_constraint = [NSLayoutConstraint constraintWithItem:arcview
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:37.f];
    [hud.customView addConstraints:@[w_constraint,h_constraint]];
    hud.margin = 13.f;
    
    if (text) {
        hud.label.text = text;
    }
    
}


- (void)wz_dismissHud {
    if (!self.loadingHUD) {
        return;
    }
    [self.loadingHUD hideAnimated:YES];
    self.loadingHUD.removeFromSuperViewOnHide = YES;
    self.loadingHUD = nil;
}


- (void)wz_showHubText:(NSString *)text {
    [self wz_showHubText:text duration:1.5];
}

- (void)wz_showHubText:(NSString *)text duration:(NSTimeInterval)duration {
    
    if ([text isEqualToString:@""] || text == nil) {
        return;
    }
    if (self.loadingHUD) {
        [self wz_dismissHud];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.loadingHUD = hud;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    hud.detailsLabel.text = text;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.bezelView.layer.cornerRadius = 14;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:0.8];
    [hud hideAnimated:YES afterDelay:duration];
    [self performSelector:@selector(clearLoadingHUD) withObject:nil afterDelay:duration];
}

- (void)clearLoadingHUD {
    self.loadingHUD = nil;
}



#pragma mark - abjc runtime

- (FITArcView *)arcView {
    return objc_getAssociatedObject(self, @selector(arcView));
}

- (void)setArcView:(FITArcView *)arcView {
    objc_setAssociatedObject(self, @selector(arcView), arcView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBProgressHUD *)loadingHUD {
    return objc_getAssociatedObject(self, @selector(loadingHUD));
}

- (void)setLoadingHUD:(MBProgressHUD *)loadingHUD {
    objc_setAssociatedObject(self, @selector(loadingHUD), loadingHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
