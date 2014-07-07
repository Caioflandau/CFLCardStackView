//
//  CFLCardStackViewPanGestureRecognizer.h
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 02/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFLCardView.h"
#import "CFLCardStackNode.h"

@protocol CFLCardStackViewPanGestureRecognizerDelegate <NSObject>

-(void)cardPanDelegateDidStartMovingTopCard;
-(void)cardPanDelegateDidMoveTopCard:(CGFloat)delta;
-(void)cardPanDelegateDidCancelSwipe;
-(void)cardPanDelegateDidSwipe;

-(BOOL)shouldSwipeAway;

//-(CFLCardView*)topCardView;
-(CFLCardStackNode*)topCardNode;

@end

@interface CFLCardStackViewPanGestureRecognizer : UIPanGestureRecognizer

@property id<CFLCardStackViewPanGestureRecognizerDelegate> cardStackPanGestureDelegate;

@end
