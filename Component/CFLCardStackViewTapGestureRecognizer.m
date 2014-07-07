//
//  CFLCardStackViewTapGestureRecognizer.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 07/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackViewTapGestureRecognizer.h"

@implementation CFLCardStackViewTapGestureRecognizer

-(id)init {
    self = [super initWithTarget:self action:@selector(onTap)];
    if (self) {
    }
    return self;
}

-(void)onTap {
    if (self.state == UIGestureRecognizerStateEnded) {
        [self.cardStackTapGestureDelegate didTapTopCard];
    }
}

@end
