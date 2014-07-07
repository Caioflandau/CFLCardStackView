//
//  CFLCardStackViewTapGestureRecognizer.h
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 07/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CFLCardStackViewTapGestureRecognizerDelegate;

@interface CFLCardStackViewTapGestureRecognizer : UITapGestureRecognizer

@property id<CFLCardStackViewTapGestureRecognizerDelegate> cardStackTapGestureDelegate;

@end

@protocol CFLCardStackViewTapGestureRecognizerDelegate <NSObject>

-(void)didTapTopCard;

@end