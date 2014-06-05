//
//  CFLCardStackView.m
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 04/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardStackView.h"
#import "CFLCardPanGesture.h"

@interface CFLCardStackView () {
    CFLCardPanGesture *gestureRecognizer;
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
    gestureRecognizer = [[CFLCardPanGesture alloc] init];
    gestureRecognizer.cardStackView = self;
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
    
    for (NSInteger i = self.cardViews.count-1; i >= 0; i--) {
        
        if (i >= 3)
            continue;
        
        NSLog(@"i = %d", i);
        
        UIView *view = [self.cardViews objectAtIndex:i];
        
        CGPoint center = [self convertPoint:self.center fromView:view];
        
        switch (i) {
            case 2:
                view.alpha = 0.5;
                center.x = center.x+10;
                center.y = center.y-10;
                break;
                
            case 1:
                view.alpha = 0.75;
                center.x = center.x;
                center.y = center.y;
                break;
                
            case 0:
                view.alpha = 1;
                center.x = center.x - 10;
                center.y = center.y + 10;
                break;
                
            default:
                view.alpha = 0;
                break;
        }
        
        view.center = center;
        
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

-(UIView *)topCardView {
    return [self.cardViews firstObject];
}

@end
