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

@property CFLCardStackNode *previousNode;
@property CFLCardStackNode *nextNode;


-(id)initWithCardIndex:(NSInteger)cardIndex;

@end
