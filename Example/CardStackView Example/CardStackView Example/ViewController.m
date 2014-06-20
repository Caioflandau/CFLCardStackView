//
//  ViewController.m
//  CardStackView Example
//
//  Created by  Caio Landau on 6/19/14.
//  Copyright (c) 2014 caioflandau. All rights reserved.
//

#import "ViewController.h"
#import "CFLCardStackView.h"
#import "CardViewController.h"

@interface ViewController () <CFLCardStackViewDataSource, CFLCardStackViewDelegate>

@property IBOutlet CFLCardStackView *stackView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stackView.delegate = self;
    self.stackView.dataSource = self;
    [self.stackView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CFLCardStackViewDelegate
-(void)cardStackView:(CFLCardStackView *)cardStackView didSelectCardAtIndex:(NSInteger)index {
    
}

-(UIView *)cardStackView:(CFLCardStackView *)cardStackView viewForCardAtIndex:(NSInteger)index {
    CardViewController *cardViewController = [[CardViewController alloc] init];
    UIView *view = cardViewController.view;
    [cardViewController setRandomBackgroundColor];
    cardViewController.lblNumber.text = [NSString stringWithFormat:@"%d", (int)index];
    return view;
}

-(NSInteger)numberOfCardsInCardStackView:(CFLCardStackView *)cardStackView {
    return 5;
}

@end
