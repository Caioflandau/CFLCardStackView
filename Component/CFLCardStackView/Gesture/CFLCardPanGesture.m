//
//  CFLCardPanGesture.m
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 05/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardPanGesture.h"

@interface CFLCardPanGesture () {
    CGPoint startingCardCenter;
    BOOL mustRotateStack;
}

@end

@implementation CFLCardPanGesture
@synthesize cardStackView = _cardStackView;

-(void)setCardStackView:(CFLCardStackView *)cardStackView {
    _cardStackView = cardStackView;
    self.gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onDrag:)];
    [_cardStackView addGestureRecognizer:self.gestureRecognizer];
}
-(CFLCardStackView *)cardStackView {
    return _cardStackView;
}

-(void) onDrag:(UIPanGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        [self gestureBegan:recognizer];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self gestureChanged:recognizer];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self gestureEnded:recognizer];
    }
}


#pragma mark - Parse gesture statuses

-(void)gestureBegan:(UIPanGestureRecognizer*)recognizer {
    startingCardCenter = self.cardStackView.topCardView.center;
}

-(void)gestureChanged:(UIPanGestureRecognizer*)recognizer {
    
//    self.cardStackView.topCardView.layer.transform
    
    CGPoint deltaCenter = [recognizer translationInView:self.cardStackView.superview];
    
    CGFloat rotationDelta = deltaCenter.x > 150 ? 150 : deltaCenter.x;
    
    int multiplier = [self rotationMultiplierForTouchAtPoint:[recognizer locationOfTouch:0 inView:self.cardStackView.topCardView]];
    self.cardStackView.topCardView.layer.transform = CATransform3DMakeRotation(multiplier * ((M_PI_4*0.5) * rotationDelta/150.0), 0.0, 0.0, 1.0);
    
    [self.cardStackView.topCardView setCenter:CGPointMake(startingCardCenter.x+deltaCenter.x/2, startingCardCenter.y+deltaCenter.y/2)];
    if (abs(deltaCenter.x) > 150 || abs(deltaCenter.y) > 150) {
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.cardStackView.topCardView.alpha = 0.8;
        }];
        mustRotateStack = YES;
    }
    else {
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.cardStackView.topCardView.alpha = 1;
        }];
        mustRotateStack = NO;
    }
}

-(void)gestureEnded:(UIPanGestureRecognizer*)recognizer {
    if (!mustRotateStack) {
        [UIView animateWithDuration:0.3 animations:^(void) {
            self.cardStackView.topCardView.center = startingCardCenter;
            self.cardStackView.topCardView.alpha = 1;
            self.cardStackView.topCardView.layer.transform = CATransform3DMakeRotation(0, 0.0, 0.0, 0.0);
        }];
    }
    else {
        [UIView animateWithDuration:0.2 animations:^(void) {
            CGPoint deltaCenter = [recognizer translationInView:self.cardStackView.superview];
            [self.cardStackView.topCardView setCenter:CGPointMake(startingCardCenter.x+deltaCenter.x, startingCardCenter.y+deltaCenter.y)];
            self.cardStackView.topCardView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        } completion:^(BOOL finished) {
            [self.cardStackView sendSubviewToBack:self.cardStackView.topCardView];
            [UIView animateWithDuration:0.3 animations:^(void) {
                CGPoint backCardCenter = CGPointMake(startingCardCenter.x+30, startingCardCenter.y-30);
                self.cardStackView.topCardView.center = backCardCenter;
            } completion:^(BOOL finished) {
                self.cardStackView.topCardView.alpha = 1;
                self.cardStackView.topCardView.transform = CGAffineTransformMakeScale(1, 1);
                [self.cardStackView rotateStack];
            }];
        }];
    }
}

-(int)rotationMultiplierForTouchAtPoint:(CGPoint)touchPoint {
    if (touchPoint.y > self.cardStackView.topCardView.frame.size.height / 2.0) {
        return -1;
    }
    else {
        return 1;
    }
}

@end
