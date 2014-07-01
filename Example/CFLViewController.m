//
//  CFLViewController.m
//  CFLCardStackView
//
//  Created by Caio Fukelmann Landau on 01/07/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLViewController.h"
#import "CFLCardStackView.h"
#import "CFLExampleCardViewController.h"

@interface CFLViewController () <CFLCardStackViewDelegate, CFLCardStackViewDataSource> {
    CFLCardStackView *cardStackView;
    NSMutableArray *viewControllers;
}

@end

@implementation CFLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    cardStackView = [[CFLCardStackView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    cardStackView.delegate = self;
    cardStackView.dataSource = self;
    [self.view addSubview:cardStackView];
    viewControllers = [[NSMutableArray alloc] init];
    [cardStackView reloadData];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CFLCardStackViewDataSource

-(CFLCardView *)cardStackView:(CFLCardStackView *)cardStackView cardViewForCardAtIndex:(NSInteger)cardIndex {
    
    CFLExampleCardViewController *cardVc;
    
    if (viewControllers.count <= cardIndex) {
        CFLExampleCardViewController *vc = [[CFLExampleCardViewController alloc] init];
        [viewControllers addObject:vc];
        vc.view.frame = CGRectMake(50, 160, self.view.frame.size.width-100, self.view.frame.size.height-320);
        cardVc = vc;
    }
    else {
        cardVc = [viewControllers objectAtIndex:cardIndex];
    }
    cardVc.lblNumber.text = [NSString stringWithFormat:@"%d", cardIndex];
    return (CFLCardView*)cardVc.view;
}

-(NSInteger)numberOfCardsInStackView:(CFLCardStackView *)cardStackView {
    return 10;
}


#pragma mark - CFLCardStackViewDelegate

-(void)cardStackView:(CFLCardStackView *)cardStackView didSelectTopCard:(CFLCardView *)topCardView {
    
}

@end
