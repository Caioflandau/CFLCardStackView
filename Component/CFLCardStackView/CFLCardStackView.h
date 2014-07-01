//
//  CFLCardStackView.h
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 04/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - Interface
@interface CFLCardStackView : UIView

@property (readonly) UIView *topCardView;

/**
 @return the topmost card view behind topCardView or nil if there are no cards behind
 */
-(UIView*)cardViewBehind:(UIView*)topCardView;

-(UIView*)dequeueViewForCardAtIndex:(NSInteger)index;
-(void)reloadData;
-(void)rotateStack;


-(void)adjustPositionOfCardViewBehindForDelta:(float)delta WithInitialTransform:(CGAffineTransform)initialTransform;

@end



#pragma mark - DataSource

@protocol CFLCardStackViewDataSource <NSObject>

-(NSInteger)numberOfCardsInCardStackView:(CFLCardStackView*)cardStackView;

-(UIView*)cardStackView:(CFLCardStackView*)cardStackView viewForCardAtIndex:(NSInteger)index;

@end



#pragma mark - Delegate

@protocol CFLCardStackViewDelegate <NSObject>

-(void)cardStackView:(CFLCardStackView*)cardStackView didSelectCardAtIndex:(NSInteger)index;

@end



#pragma mark - Interface Extension
@interface CFLCardStackView ()

@property id<CFLCardStackViewDataSource> dataSource;
@property id<CFLCardStackViewDelegate> delegate;

@end