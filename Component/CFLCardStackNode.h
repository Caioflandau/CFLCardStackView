//
//  CFLCardStackNode.h
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 02/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFLCardView.h"

@interface CFLCardStackNode : NSObject

@property (weak) CFLCardView *cardView;
@property NSInteger cardIndex;

@property CFLCardStackNode *nextNode;
@property CFLCardStackNode *previousNode;

-(id)initWithCardIndex:(NSInteger)cardIndex;
-(id)initWithCardIndex:(NSInteger)cardIndex andNextNode:(CFLCardStackNode*)nextNode;
-(id)initWithCardIndex:(NSInteger)cardIndex andPreviousNode:(CFLCardStackNode*)previousNode;

@end
