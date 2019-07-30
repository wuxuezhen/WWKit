//
//  UIResponder+ReverseEvent.m
//  MiGuKit
//
//  Created by 宋乃银 on 2018/11/9.
//  Copyright © 2018 Migu Video Technology. All rights reserved.
//

#import "UIResponder+ReverseEvent.h"
#import <objc/runtime.h>

@implementation UIResponder (ReverseEvent)

- (void)routerReverseEvent:(NSString *)eventName info:(id)info {
     [[self getMgHasTable] removeAllObjects];
    if ([self isKindOfClass:[UIViewController class]]) {
        NSArray<UIViewController *> *vcs = [(UIViewController *)self childViewControllers];
        NSHashTable *table = [self getMgHasTable];
        for (UIViewController *vc in vcs) {
            [table addObject:vc];
        }
    }
    [self routerReverseEvent:eventName info:info targetResponder:self];
    [self routerReverseEventToVC:eventName info:info];
}

- (void)routerReverseEventToVC:(NSString *)eventName info:(id)info {
    NSHashTable<UIViewController *> *table = [self getMgHasTable];
    for (UIViewController *vc in table) {
        NSDictionary *eventDic = [vc getMgEventDic:NO][eventName];
        if (eventDic) {
            EventBlock block = eventDic[@"EventBlockKey"];
            if (block) {
                block(info);
            }
        }
    }
}

- (void)routerReverseEvent:(NSString *)eventName info:(id)info targetResponder:(UIResponder *)resp {
    if (!eventName || !resp) { return; }
    NSHashTable<UIViewController *> *table = [self getMgHasTable];
    if ([resp isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)resp;
        [table addObject:vc];
        [self routerReverseEvent:eventName info:info targetResponder:vc.view];
    } else if ([resp isKindOfClass:[UIView class]]) {
        UIView *view = (UIView *)resp;
        UIViewController *vc = [view getMgParentController];
        [table addObject:vc];
        
        NSDictionary *eventDic = [view getMgEventDic:NO][eventName];
        if (eventDic) {
            EventBlock block = eventDic[@"EventBlockKey"];
            if (block) {
                block(info);
            }
        }
        NSArray *subviews = view.subviews;
        for (UIView *subView in subviews) {
            [self routerReverseEvent:eventName info:info targetResponder:subView];
        }
    }
}

- (void)registerReverseEvent:(NSString *)eventName block:(EventBlock)block {
    if (!eventName || !block) { return; }
    NSMutableDictionary *eventDic = [self getMgEventDic:YES];
    NSMutableDictionary *dict = eventDic[eventName];
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        eventDic[eventName] = dict;
    }
    dict[@"EventBlockKey"] = block;
}

- (UIViewController*)getMgParentController {
    UIResponder *responder = self;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}


- (NSMutableDictionary *)getMgEventDic:(BOOL)force {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict && force) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSHashTable<UIViewController *> *)getMgHasTable {
    NSHashTable *table = objc_getAssociatedObject(self, _cmd);
    if (!table) {
        table = [NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, _cmd, table, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return table;
}

@end
