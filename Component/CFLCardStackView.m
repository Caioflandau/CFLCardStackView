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
#import "CFLCardStackViewTapGestureRecognizer.h"

@interface CFLCardStackView () <CFLCardStackViewPanGestureRecognizerDelegate, CFLCardStackViewTapGestureRecognizerDelegate>

@property NSUInteger numberOfCards;

@property CFLCardStackNode *lastPeekingNode;

@end

@implementation CFLCardStackView

@synthesize topCardNode = _topCardNode;
@synthesize numberOfCardsBehind = _numberOfCardsBehind;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CFLCardStackViewPanGestureRecognizer *gestureRecognizer = [[CFLCardStackViewPanGestureRecognizer alloc] init];
        gestureRecognizer.cardStackPanGestureDelegate = self;
        
        CFLCardStackViewTapGestureRecognizer *tapGestureRecognizer = [[CFLCardStackViewTapGestureRecognizer alloc] init];
        tapGestureRecognizer.cardStackTapGestureDelegate = self;
        
        [self addGestureRecognizer:tapGestureRecognizer];
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
    if (self.numberOfCards > 0) {
        [self constructLinkedList];
        for (NSInteger i = 0; i <= self.numberOfCardsBehind; i++) {
            [self putNextCardView];
        }
    }
}

-(void)removeAllCards {
    CFLCardStackNode *startingNode = self.topCardNode;
    CFLCardStackNode *node = startingNode.nextNode;
    do {
        [node.cardView removeFromSuperview];
        node.cardView = nil;
        node = node.nextNode;
    } while (![node isEqual:startingNode] && node != nil);
}

-(void)constructLinkedList {
    if (self.numberOfCards <= 0)
        return;
    
    CFLCardStackNode *node = [[CFLCardStackNode alloc] initWithCardIndex:0];
    CFLCardStackNode *firstNode = node;
    NSInteger i = 0;
    do {
        i++;
        CFLCardStackNode *newNode = [[CFLCardStackNode alloc] initWithCardIndex:i andPreviousNode:node];
        node.nextNode = newNode;
        node = newNode;
    } while (i < self.numberOfCards-1);
    node.nextNode = firstNode;
    firstNode.previousNode = node;
    _topCardNode = firstNode;
}

-(void)putNextCardView {
    if (self.lastPeekingNode == nil) {
        [self putCardView:self.topCardNode];
        self.lastPeekingNode = self.topCardNode;
    }
    else {
        [self putCardView:self.lastPeekingNode.nextNode];
        self.lastPeekingNode = self.lastPeekingNode.nextNode;
    }
}

-(void)putCardView:(CFLCardStackNode*)cardNode {
    if (cardNode.cardView == nil) {
        cardNode.cardView = [self.dataSource cardStackView:self cardViewForCardAtIndex:cardNode.cardIndex];
        cardNode.cardView.alpha = 0;
    }
    
    [self addSubview:cardNode.cardView];
    [self sendSubviewToBack:cardNode.cardView];
    
    do {
        [self layoutCardView:cardNode];
        cardNode = cardNode.previousNode;
    } while (cardNode != self.topCardNode);

    [self layoutCardView:self.topCardNode];
}

-(void)layoutCardView:(CFLCardStackNode*)cardNode {
    CFLCardStackNode *node = cardNode;
    NSInteger distance = 0;
    while (node != self.topCardNode) {
        distance--;
        node = node.previousNode;
    }
    if (cardNode.cardView.alpha == 0) {
        cardNode.cardView.transform = CGAffineTransformMakeTranslation(0, self.cardSpreadDistance * distance);
    }

    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, distance*self.cardSpreadDistance);
    
    CGFloat scaleRatio = -(self.cardSpreadDistance*distance*2.0);
    scaleRatio = (cardNode.cardView.frame.size.height - scaleRatio) / cardNode.cardView.frame.size.height;
    
    NSLog(@"scaleRatio %f", scaleRatio);
    
    transform = CGAffineTransformScale(transform, scaleRatio, 1.0);
    
    [UIView animateWithDuration:0.2 animations:^{
        cardNode.cardView.transform = transform;
        cardNode.cardView.alpha = 1.0/* + ((float)distance*0.1)*/;
    }];
}

#pragma mark - CFLCardStackViewPanGestureRecognizerDelegate
-(void)cardPanDelegateDidStartMovingTopCard {
}

-(void)cardPanDelegateDidMoveTopCard:(CGFloat)delta {
    
}

-(void)cardPanDelegateDidCancelSwipe {
    
}
-(void)cardPanDelegateDidSwipe {
    [self.topCardNode.cardView removeFromSuperview];
    _topCardNode = self.topCardNode.nextNode;
    [self putNextCardView];
}

-(BOOL)shouldSwipeAway {
    if (self.numberOfCards <= 1)
        return NO;
    else
        return YES;
}

-(void)didTapTopCard {
    if ([self.delegate respondsToSelector:@selector(cardStackView:didSelectTopCard:)]) {
        [self.delegate cardStackView:self didSelectTopCard:[self topCardView]];
    }
}

#pragma mark - Getter/Setter

-(CFLCardView *)topCardView {
    return self.topCardNode.cardView;
}

-(void)setNumberOfCardsBehind:(NSInteger)numberOfCardsBehind {
    _numberOfCardsBehind = numberOfCardsBehind;
}

-(NSInteger)numberOfCardsBehind {
    if (_numberOfCardsBehind > self.numberOfCards-1) {
        return self.numberOfCards-1;
    }
    return _numberOfCardsBehind;
}

@end
