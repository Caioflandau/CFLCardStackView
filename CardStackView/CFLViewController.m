//
//  CFLViewController.m
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 04/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLViewController.h"
#import "CFLCardStackView.h"
#import "CFLCardViewController.h"

@interface CFLViewController () <CFLCardStackViewDataSource, CFLCardStackViewDelegate>
@property (strong, nonatomic) IBOutlet CFLCardStackView *cardStackView;

@end

@implementation CFLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cardStackView.dataSource = self;
    [self.cardStackView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CFLCardStackViewDelegate

-(void)cardStackView:(CFLCardStackView *)cardStackView didSelectCardAtIndex:(NSInteger)index {
    
}

#pragma mark - CFLCardStackViewDataSource

-(UIView *)cardStackView:(CFLCardStackView *)cardStackView viewForCardAtIndex:(NSInteger)index {
    UIView *view = [cardStackView dequeueViewForCardAtIndex:index];
    if (view == nil) {
        CFLCardViewController *cardVc = [[CFLCardViewController alloc] init];
        view = cardVc.view;
        cardVc.lblText.text = [NSString stringWithFormat:@"Card #%d", index];
    }
    return view;
}

-(NSInteger)numberOfCardsInCardStackView:(CFLCardStackView *)cardStackView {
    return 10;
}

@end
