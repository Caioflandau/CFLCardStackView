//
//  CFLCardStackView.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 01/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackView.h"
#import "CFLCardStackViewPanGestureRecognizer.h"
#import "CFLCardStackNode.m"

#define TRANSLATION_OFFSET -30

@interface CFLCardStackView () <CFLCardStackViewPanGestureRecognizerDelegate>

@property CFLCardStackNode *currentTopNode;

@property NSUInteger numberOfCards;
@end

@implementation CFLCardStackView

@synthesize topCardView = _topCardView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CFLCardStackViewPanGestureRecognizer *gestureRecognizer = [[CFLCardStackViewPanGestureRecognizer alloc] init];
        gestureRecognizer.cardStackPanGestureDelegate = self;
        [self addGestureRecognizer:gestureRecognizer];
        self.numberOfCardsBehind = 2;
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
    [self constructLinkedList];
    [self putViews];
}

-(void)constructLinkedList {
    self.currentTopNode = [[CFLCardStackNode alloc] initWithCardIndex:0];
    
    for (NSInteger i = 0; i < self.numberOfCards; i++) {
        CFLCardStackNode *nextNode = [[CFLCardStackNode alloc] initWithCardIndex:i];
        self.currentTopNode.nextNode = nextNode;
        self.currentTopNode = nextNode;
    }
}

-(void)putViews {
    //TODO: Put views using [self.dataSource cardStackView:<#(CFLCardStackView *)#> cardViewForCardAtIndex:<#(NSInteger)#>] for visible nodes
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
    return _topCardView;
}

@end
