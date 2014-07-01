//
//  CFLCardStackView.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 01/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackView.h"

@interface CFLCardStackView ()

@property NSUInteger numberOfCards;

@end

@implementation CFLCardStackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    [self construct];
}

-(void)construct {
    if (self.numberOfCards <= 0)
        return;
    
    NSInteger lastPeekCardIndex = self.numberOfCards - self.numberOfCardsBehind - 1;
    if (lastPeekCardIndex < 0) {
        lastPeekCardIndex = 0;
        self.numberOfCardsBehind = self.numberOfCards-1;
        lastPeekCardIndex = self.numberOfCards - self.numberOfCardsBehind - 1;
    }
    
    NSInteger lastIndex = self.numberOfCards-1;
    for (NSInteger i = lastPeekCardIndex; i <= lastIndex; i++) {
        CFLCardView *cardView = [self.dataSource cardStackView:self cardViewForCardAtIndex:i];
        NSInteger translateDelta = -30 * (lastIndex - i);
        cardView.transform = CGAffineTransformMakeTranslation(0, translateDelta);
        CGFloat scaleDelta = 1.f - ((float)lastIndex - (float)i)/(float)lastIndex;
        cardView.transform = CGAffineTransformScale(cardView.transform, scaleDelta, scaleDelta);
        [self addSubview:cardView];
    }
}

@end
