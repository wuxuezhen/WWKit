//
//  UIControl+YYAdd.m
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 13/4/5.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "UIControl+YYAddMG.h"
#import <objc/runtime.h>
#import "MGMacro.h"

YYSYNTH_DUMMY_CLASS(UIControl_YYAddMG)

static const int block_keyMG;

@interface _YYUIControlBlockTargetMG : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation _YYUIControlBlockTargetMG

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end



@implementation UIControl (YYAddMG)

- (void)removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self _yy_allUIControlBlockTargetsMG] removeAllObjects];
}

- (void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
                forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)addBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    if (!controlEvents) return;
    _YYUIControlBlockTargetMG *target = [[_YYUIControlBlockTargetMG alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self _yy_allUIControlBlockTargetsMG];
    [targets addObject:target];
}

- (void)setBlockForControlEvents:(UIControlEvents)controlEvents
                           block:(void (^)(id sender))block {
    [self removeAllBlocksForControlEvents:UIControlEventAllEvents];
    [self addBlockForControlEvents:controlEvents block:block];
}

- (void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self _yy_allUIControlBlockTargetsMG];
    NSMutableArray *removes = [NSMutableArray array];
    for (_YYUIControlBlockTargetMG *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)_yy_allUIControlBlockTargetsMG {
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_keyMG);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_keyMG, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}

@end
