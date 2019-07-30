//
//  UIView+Event.m
//  MiGuKit
//
//  Created by zhgz on 2018/3/28.
//  Copyright © 2018年 Migu Video Technology. All rights reserved.
//

#import "UIView+Event.h"
#import <objc/runtime.h>
#import "UIControl+YYAddMG.h"
#import "MGMacro.h"

@interface UIView (P_WhenTappedBlocks)

- (void)runBlockForKey:(void *)blockKey;
- (void)setBlock:(TouchBlock)block forKey:(void *)blockKey;

- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger) taps touches:(NSUInteger) touches selector:(SEL) selector;
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizerSelector:(SEL)selector;
- (void) addRequirementToSingleTapsRecognizer:(UIGestureRecognizer*) recognizer;
- (void) addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer*) recognizer;

@end

@implementation UIView (Event)

static char kWhenTappedBlockKey;
static char kWhenDoubleTappedBlockKey;
static char kWhenTwoFingerTappedBlockKey;
static char kWhenTouchedDownBlockKey;
static char kWhenTouchedUpBlockKey;
static char kWhenClickBlockKey;
static char kWhenLongPressBlockKey;

#pragma mark Set blocks

- (void)runBlockForKey:(void *)blockKey {
	TouchBlock block = objc_getAssociatedObject(self, blockKey);
	if (block) block();
}

- (void)setBlock:(TouchBlock)block forKey:(void *)blockKey {
	self.userInteractionEnabled = YES;
	objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark When Tapped

/**
 手势 单击
 @param block TouchBlock
 */
- (void)blockTapped:(TouchBlock)block {
	[self setBlock:block forKey:&kWhenTappedBlockKey];
	if (!block) return;
	
	[self removeTapGestureRecognizerWithTaps:1 touches:1];
	UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped)];
	[self addRequiredToDoubleTapsRecognizer:gesture];
}

/**
 手势 双击
 @param block TouchBlock
 */
- (void)blockDoubleClick:(TouchBlock)block {
	[self setBlock:block forKey:&kWhenDoubleTappedBlockKey];
	if (!block) return;

	[self removeTapGestureRecognizerWithTaps:2 touches:1];
	UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:2 touches:1 selector:@selector(viewWasDoubleTapped)];
	[self addRequirementToSingleTapsRecognizer:gesture];
}

/**
 手势 双指点击
 @param block TouchBlock
 */
- (void)blockTwoFingerTapped:(TouchBlock)block {
	[self setBlock:block forKey:&kWhenTwoFingerTappedBlockKey];
	if (!block) return;

	[self removeTapGestureRecognizerWithTaps:1 touches:2];
	[self addTapGestureRecognizerWithTaps:1 touches:2 selector:@selector(viewWasTwoFingerTapped)];
}

- (void)blockTouchedDown:(TouchBlock)block {
	if (!block) return;
	[self setBlock:block forKey:&kWhenTouchedDownBlockKey];
}

- (void)blockTouchedUp:(TouchBlock)block {
	if (!block) return;
	[self setBlock:block forKey:&kWhenTouchedUpBlockKey];
}

/**
 事件 点击
 @param block TouchBlock
 */
- (void)blockClick:(TouchBlock)block {
	[self setBlock:block forKey:&kWhenClickBlockKey];
	if (!block) return;

	if([self isKindOfClass:[UIControl class]]){
		@weakify(self);
		[((UIControl *) self) removeAllBlocksForControlEvents:UIControlEventTouchUpInside];
        [((UIControl *) self) addBlockForControlEvents:UIControlEventTouchUpInside
                                                 block:^(id sender) {
                                                     @strongify(self);
                                                     [self runBlockForKey:&kWhenClickBlockKey];
                                                 }];
	}
}

//长按手势
- (void)blockLongPress:(TouchBlock)block {
	[self setBlock:block forKey:&kWhenLongPressBlockKey];
	if (!block) return;

	[self removeLongPressGestureRecognizer];
	[self addLongPressGestureRecognizerSelector:@selector(viewWasLongPressed:)];
}

#pragma mark Callbacks

- (void)viewWasTapped {
	[self runBlockForKey:&kWhenTappedBlockKey];
}

- (void)viewWasDoubleTapped {
	[self runBlockForKey:&kWhenDoubleTappedBlockKey];
}

- (void)viewWasTwoFingerTapped {
	[self runBlockForKey:&kWhenTwoFingerTappedBlockKey];
}

- (void)viewWasLongPressed:(UITapGestureRecognizer *)gesture {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		[self runBlockForKey:&kWhenLongPressBlockKey];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self runBlockForKey:&kWhenTouchedDownBlockKey];
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//	[self runBlockForKey:&kWhenTouchedUpBlockKey];
	if(![self isKindOfClass:[UIControl class]]){
		UITouch *touch = touches.anyObject;
		CGPoint p = [touch locationInView:self];
		if (CGRectContainsPoint(self.bounds, p)) {
			if([touch.view isEqual:self]){
				[self runBlockForKey:&kWhenClickBlockKey];
			}
		}
	}
	[super touchesEnded:touches withEvent:event];
}

#pragma mark Helpers

- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
	UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
	tapGesture.delegate = self;
	tapGesture.numberOfTapsRequired = taps;
	tapGesture.numberOfTouchesRequired = touches;
	[self addGestureRecognizer:tapGesture];

	return tapGesture;
}

- (void)removeTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches {
	for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
			if (tapGesture.numberOfTapsRequired == taps && tapGesture.numberOfTouchesRequired == touches ) {
				[self removeGestureRecognizer:tapGesture];
			}
		}
	}
}

- (UILongPressGestureRecognizer*)addLongPressGestureRecognizerSelector:(SEL)selector {
	UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:selector];
	gesture.delegate = self;
	[self addGestureRecognizer:gesture];

	return gesture;
}

- (void)removeLongPressGestureRecognizer {
	for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
		if([recognizer isKindOfClass:UILongPressGestureRecognizer.class]){
			[self removeGestureRecognizer:recognizer];
		}
	}
}

- (void)addRequirementToSingleTapsRecognizer:(UIGestureRecognizer*) recognizer {
	for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
			if (tapGesture.numberOfTouchesRequired == 1 && tapGesture.numberOfTapsRequired == 1) {
				[tapGesture requireGestureRecognizerToFail:recognizer];
			}
		}
	}
}

- (void)addRequiredToDoubleTapsRecognizer:(UIGestureRecognizer*) recognizer {
	for (UIGestureRecognizer* gesture in [self gestureRecognizers]) {
		if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
			UITapGestureRecognizer* tapGesture = (UITapGestureRecognizer*) gesture;
			if (tapGesture.numberOfTouchesRequired == 2 && tapGesture.numberOfTapsRequired == 1) {
				[recognizer requireGestureRecognizerToFail:tapGesture];
			}
		}
	}
}

@end
