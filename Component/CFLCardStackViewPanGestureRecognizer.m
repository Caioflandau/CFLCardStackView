//
//  CFLCardStackViewPanGestureRecognizer.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 02/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackViewPanGestureRecognizer.h"

@interface CFLCardStackViewPanGestureRecognizer () {
    BOOL isRemoving;
}

@end

@implementation CFLCardStackViewPanGestureRecognizer

-(id)init {
    self = [super initWithTarget:self action:@selector(gestureStateChanged)];
    if (self) {
        
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
    CFLCardView *topCardView = [self.cardStackPanGestureDelegate topCardView];
    CGPoint translation = [self translationInView:topCardView];
    CGFloat deltaX = translation.x/1.5;
    CGFloat deltaY = translation.y/1.5;
    topCardView.transform = CGAffineTransformMakeTranslation(deltaX, deltaY);
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
        delta = fabs(deltaX);
    else
        delta = fabs(deltaY);
    
    if (delta > 100)
        delta = 100;
    
    [self.cardStackPanGestureDelegate cardPanDelegateDidMoveTopCard:delta/100.0];
}

-(void)ended {
    CFLCardView *topCardView = [self.cardStackPanGestureDelegate topCardView];
    
    if (!isRemoving) {
        [UIView animateWithDuration:0.3 animations:^    {
            topCardView.transform = CGAffineTransformMakeTranslation(0, 0);
            topCardView.alpha = 1;
        } completion:^(BOOL finished) {
            [self.cardStackPanGestureDelegate cardPanDelegateDidCancelSwipe];
        }];
    }
    else {
        CGPoint translation = [self translationInView:topCardView];
        CGFloat deltaX = translation.x;
        CGFloat deltaY = translation.y;
        
        CGAffineTransform currentTransform = topCardView.transform;
        
        [UIView animateWithDuration:0.3 animations:^{
            topCardView.transform = CGAffineTransformMakeTranslation(deltaX*3, deltaY*3);
            topCardView.alpha = 0;
        } completion:^(BOOL finished) {
            topCardView.transform = currentTransform;
            [self.cardStackPanGestureDelegate cardPanDelegateDidSwipe];
        }];
    }
}

@end
