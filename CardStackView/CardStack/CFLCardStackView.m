//
//  CFLCardStackView.m
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 04/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackView.h"

@interface CFLCardStackView () {
}

@property (nonatomic) NSInteger numberOfCards;
@property (nonatomic) NSArray *cardViews;

@end

@implementation CFLCardStackView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)awakeFromNib {
    [self reloadData];
}

-(void)reloadData {
    self.numberOfCards = [self.dataSource numberOfCardsInCardStackView:self];
    
    NSMutableArray *views = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.numberOfCards; i++) {
        UIView *nextCardView = [self.dataSource cardStackView:self viewForCardAtIndex:i];
        [views addObject:nextCardView];
    }
    self.cardViews = views;
    [self putCardViews];
}

-(void)putCardViews {
    //Remove all cards...
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (NSInteger i = self.cardViews.count; i > 0; i--) {
        UIView *view = [self.cardViews objectAtIndex:i-1];
        view.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:view];
    }
}

-(UIView *)dequeueViewForCardAtIndex:(NSInteger)index {
    UIView *view = nil;
    if (self.cardViews.count > index) {
        view = [self.cardViews objectAtIndex:index];
    }
    return view;
}

@end
