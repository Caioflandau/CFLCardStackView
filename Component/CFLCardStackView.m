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
    if (self.numberOfCards > 0) {
        [self constructLinkedList];
        [self printLinkedList];
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
    _topCardNode = node;
}

-(void)printLinkedList {
    CFLCardStackNode *node = self.topCardNode;
    do {
        NSLog(@"%@", node);
        node = node.nextNode;
    }while (node != nil);
}

#pragma mark - CFLCardStackViewPanGestureRecognizerDelegate
-(void)cardPanDelegateDidStartMovingTopCard {
    
}

-(void)cardPanDelegateDidMoveTopCard:(CGFloat)delta {
}

-(void)cardPanDelegateDidCancelSwipe {
    
}
-(void)cardPanDelegateDidSwipe {
}

-(CFLCardView *)topCardView {
    return self.topCardNode.cardView;
}

@end
