//
//  CFLCardPanGesture.h
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 05/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFLCardStackView.h"

@interface CFLCardPanGesture : NSObject

@property CFLCardStackView *cardStackView;

@property UIPanGestureRecognizer *gestureRecognizer;

@end
