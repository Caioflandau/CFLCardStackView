//
//  CFLCardStackView.h
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 01/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFLCardView.h"
#import "CFLCardStackNode.h"

@protocol CFLCardStackViewDelegate;
@protocol CFLCardStackViewDataSource;

@interface CFLCardStackView : UIView

@property (weak) id<CFLCardStackViewDataSource> dataSource;
@property (weak) id<CFLCardStackViewDelegate> delegate;

@property (weak, readonly) CFLCardStackNode *topCardNode;

/**
 Number of cards to peek behind the top card. Default is 2;
 */
@property NSInteger numberOfCardsBehind;


/**
 Distance between two consecutive cards in a stack. Defaults to 5;
 */
@property NSInteger cardSpreadDistance;

-(void)reloadData;

@end


#pragma mark - Delegate
@protocol CFLCardStackViewDelegate <NSObject>
@optional

/**
 Notify the delegate that the top card was selected.
 */
-(void)cardStackView:(CFLCardStackView*)cardStackView didSelectTopCard:(CFLCardView*)topCardView;

@end


#pragma mark - DataSource
@protocol CFLCardStackViewDataSource <NSObject>

-(CFLCardView*)cardStackView:(CFLCardStackView*)cardStackView cardViewForCardAtIndex:(NSInteger)cardIndex;

-(NSInteger)numberOfCardsInStackView:(CFLCardStackView*)cardStackView;

@end;