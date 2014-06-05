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

-(UIView*)dequeueViewForCardAtIndex:(NSInteger)index;
-(void)reloadData;

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