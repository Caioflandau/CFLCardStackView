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
    CGPoint deltaCenter = [recognizer translationInView:self.cardStackView.superview];
    [self.cardStackView.topCardView setCenter:CGPointMake(startingCardCenter.x+deltaCenter.x/8, startingCardCenter.y+deltaCenter.y/8)];
}

-(void)gestureEnded:(UIPanGestureRecognizer*)recognizer {
    [UIView animateWithDuration:0.3 animations:^(void) {
        self.cardStackView.topCardView.center = startingCardCenter;
    }];
}

@end
