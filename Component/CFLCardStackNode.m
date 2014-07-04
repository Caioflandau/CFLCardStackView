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

-(id)initWithCardIndex:(NSInteger)cardIndex andNextNode:(CFLCardStackNode*)nextNode {
    self = [super init];
    if (self) {
        self.cardIndex = cardIndex;
        self.nextNode = nextNode;
    }
    return self;
}

-(id)initWithCardIndex:(NSInteger)cardIndex andPreviousNode:(CFLCardStackNode *)previousNode {
    self = [super init];
    if (self) {
        self.cardIndex = cardIndex;
        self.previousNode = previousNode;
    }
    return self;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"(%d -> [%d] -> %d)", (int)self.previousNode.cardIndex, (int)self.cardIndex, (int)self.nextNode.cardIndex];
}

-(BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[self class]])
        return NO;
    
    CFLCardStackNode *other = object;
    if (other.cardIndex != self.cardIndex)
        return NO;
    
    return YES;
}

@end
