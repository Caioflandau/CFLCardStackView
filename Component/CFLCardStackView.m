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
}
@end
