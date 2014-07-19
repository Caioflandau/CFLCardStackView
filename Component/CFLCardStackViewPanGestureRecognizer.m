//
//  CFLCardStackViewPanGestureRecognizer.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 02/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackViewPanGestureRecognizer.h"

@interface CFLCardStackViewPanGestureRecognizer () <UIGestureRecognizerDelegate> {
    BOOL isRemoving;
}

@end

@implementation CFLCardStackViewPanGestureRecognizer

-(id)init {
    self = [super initWithTarget:self action:@selector(gestureStateChanged)];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(void)gestureStateChanged {
    switch (self.state) {
        case UIGestureRecognizerStateBegan:
            [self began];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self changed];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self ended];
            
        default:
            break;
    }
}


-(void)began {
    [self.cardStackPanGestureDelegate cardPanDelegateDidStartMovingTopCard];
}

-(void)changed {
    CFLCardView *topCardView = [self.cardStackPanGestureDelegate topCardNode].cardView;
    
    CGPoint translation = [self translationInView:topCardView];
    CGFloat deltaX = translation.x/1.5;
    CGFloat deltaY = translation.y/1.5;
    
    if (fabs(deltaX) > 100 || fabs(deltaY) > 100) {
        topCardView.alpha = 0.9;
        isRemoving = YES;
    }
    else {
        topCardView.alpha = 1;
        isRemoving = NO;
    }
    CGFloat delta;
    if (fabs(deltaX) > fabs(deltaY))
        delta = deltaX;
    else
        delta = deltaY;
    
    if (delta > 100)
        delta = 100;
    
    CGFloat rotationDelta = translation.x > 150 ? 150 : translation.x;
    
    CGFloat multiplier = [self rotationMultiplierForTouchAtPoint:[self locationOfTouch:0 inView:topCardView]];
    topCardView.layer.transform = CATransform3DMakeRotation(multiplier * ((M_PI_4/2.0) * rotationDelta/100.0), 0.0, 0.0, 1.0);
    topCardView.layer.transform = CATransform3DTranslate(topCardView.layer.transform, deltaX, deltaY, 0);
    
    [self.cardStackPanGestureDelegate cardPanDelegateDidMoveTopCard:delta/100.0];
}

-(void)ended {
    CFLCardView *topCardView = [self.cardStackPanGestureDelegate topCardNode].cardView;
    
    BOOL shouldRemove = YES;
    
    if (isRemoving) {
        if ([self.cardStackPanGestureDelegate respondsToSelector:@selector(shouldSwipeAway)]) {
            shouldRemove = [self.cardStackPanGestureDelegate shouldSwipeAway];
        }
    }
    
    if (!isRemoving || !shouldRemove) {
        [UIView animateWithDuration:0.3 animations:^{
            topCardView.transform = CGAffineTransformMakeTranslation(0, 0);
            topCardView.alpha = 1;
        } completion:^(BOOL finished) {
            [self.cardStackPanGestureDelegate cardPanDelegateDidCancelSwipe];
        }];
    }
    else {
        [self.cardStackPanGestureDelegate cardPanDelegateDidSwipe];
        
        CGPoint translation = [self translationInView:topCardView];
        CGFloat deltaX = translation.x;
        CGFloat deltaY = translation.y;
        
        CGAffineTransform currentTransform = topCardView.transform;
        
        [UIView animateWithDuration:0.3 animations:^{
            topCardView.transform = CGAffineTransformMakeTranslation(deltaX*3, deltaY*3);
            topCardView.alpha = 0;
        } completion:^(BOOL finished) {
            topCardView.transform = currentTransform;
            [topCardView removeFromSuperview];
        }];
    }
}

-(CGFloat)rotationMultiplierForTouchAtPoint:(CGPoint)touchPoint {
    NSInteger height = CGRectGetHeight([self.cardStackPanGestureDelegate topCardNode].cardView.frame);
    
    CGFloat angleY = ((((CGFloat)touchPoint.y / (CGFloat)height) * 100) / 180.0 * M_PI);
    
    CGFloat multiplier = 1 + (-1 * (sin(angleY) * 1.8));
    
    return multiplier;
}

@end
