//
//  CFLCardStackView.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 01/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackView.h"
#import "CFLCardStackViewPanGestureRecognizer.h"
#import "CFLCardStackNode.h"

#define TRANSLATION_OFFSET -30

@interface CFLCardStackView () <CFLCardStackViewPanGestureRecognizerDelegate>

@property NSUInteger numberOfCards;

@end

@implementation CFLCardStackView

@synthesize topCardNode = _topCardNode;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CFLCardStackViewPanGestureRecognizer *gestureRecognizer = [[CFLCardStackViewPanGestureRecognizer alloc] init];
        gestureRecognizer.cardStackPanGestureDelegate = self;
        [self addGestureRecognizer:gestureRecognizer];
        self.numberOfCardsBehind = 2;
        self.cardSpreadDistance = 5;
        [self reloadData];
    }
    return self;
}

-(void)reloadData {
    if ([self.dataSource respondsToSelector:@selector(numberOfCardsInStackView:)]) {
        self.numberOfCards = [self.dataSource numberOfCardsInStackView:self];
    }
    else {
        self.numberOfCards = 0;
    }
    [self removeAllCards];
    [self constructLinkedList];
    [self putViews];
}

-(void)removeAllCards {
    CFLCardStackNode *startingNode = self.topCardNode;
    CFLCardStackNode *node = startingNode.nextNode;
    do {
        [node.cardView removeFromSuperview];
        node = node.nextNode;
    } while (node != startingNode);
}

-(void)constructLinkedList {
    
    CFLCardStackNode *lastNode = nil;
    
    for (NSInteger i = 0; i < self.numberOfCards; i++) {
        CFLCardStackNode *node = [[CFLCardStackNode alloc] initWithCardIndex:i];
        node.nextNode = lastNode;
        lastNode.previousNode = node;
        lastNode = node;
        _topCardNode = node;
        NSLog(@"%@", node);
    }
}

-(void)putViews {
    CFLCardStackNode *node = self.topCardNode;
    for (NSInteger i = 0; i < self.numberOfCardsBehind+1; i++) {
        if (node.cardView == nil)
            node.cardView = [self.dataSource cardStackView:self cardViewForCardAtIndex:node.cardIndex];
        
        [self addSubview:node.cardView];
        [self sendSubviewToBack:node.cardView];
        node = node.nextNode;
    }
    [self layoutCardViews];
}

-(void)layoutCardViews {
    CFLCardStackNode *node = self.topCardNode;
    for (NSInteger i = 0; i < self.numberOfCardsBehind+1; i++) {
        CGFloat scaleRatio = 1.0 - (i*0.1);
        CGFloat translateValue = (-0.5*((1.0-scaleRatio) * node.cardView.frame.size.height)) - (i*self.cardSpreadDistance);
        
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, translateValue);
        transform = CGAffineTransformScale(transform, scaleRatio, scaleRatio);
        node.cardView.transform = transform;
        node = node.nextNode;
    }
}

#pragma mark - CFLCardStackViewPanGestureRecognizerDelegate
-(void)cardPanDelegateDidStartMovingTopCard {
    
}

-(void)cardPanDelegateDidMoveTopCard:(CGFloat)delta {
    NSLog(@"cardPanDelegateDidMoveTopCard: %.3f", delta);
}

-(void)cardPanDelegateDidCancelSwipe {
    
}
-(void)cardPanDelegateDidSwipe {
    
}

-(CFLCardView *)topCardView {
    return self.topCardNode.cardView;
}

@end
