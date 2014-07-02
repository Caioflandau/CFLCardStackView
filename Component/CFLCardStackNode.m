//
//  CFLCardStackNode.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 02/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackNode.h"

@implementation CFLCardStackNode

-(id)initWithCardIndex:(NSInteger)cardIndex {
    self = [super init];
    if (self) {
        self.cardIndex = cardIndex;
    }
    return self;
}

@end
