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
    cardStackView = [[CFLCardStackView alloc] initWithFrame:CGRectMake(30, 30, self.view.frame.size.width-60, self.view.frame.size.height-60)];
    cardStackView.delegate = self;
    cardStackView.dataSource = self;
    [self.view addSubview:cardStackView];
    cardStackView.numberOfCardsBehind = 2;
    cardStackView.cardSpreadDistance = 15;
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
    
//    NSLog(@"cardViewForCardAtIndex: %d", (int)cardIndex);
    
    CFLExampleCardViewController *cardVc;
    
    if (viewControllers.count <= cardIndex) {
        CFLExampleCardViewController *vc = [[CFLExampleCardViewController alloc] init];
        [viewControllers addObject:vc];
        vc.view.frame = CGRectMake(0, 80, self.view.frame.size.width-50, self.view.frame.size.height-160);
        vc.view.backgroundColor = [self randomColor];
        cardVc = vc;
    }
    else {
        cardVc = [viewControllers objectAtIndex:cardIndex];
    }
    cardVc.lblNumber.text = [NSString stringWithFormat:@"%d", (int)cardIndex];
    return (CFLCardView*)cardVc.view;
}

-(NSInteger)numberOfCardsInStackView:(CFLCardStackView *)cardStackView {
    return 5;
}


#pragma mark - CFLCardStackViewDelegate

-(void)cardStackView:(CFLCardStackView *)cardStackView didSelectTopCard:(CFLCardView *)topCardView {
    NSLog(@"didSelectTopCard");
}



#pragma mark - IBAction

- (IBAction)touchUpReload:(UIButton *)sender {
    [cardStackView reloadData];
}


#pragma mark - Utility
-(UIColor*)randomColor {
    int r = arc4random()%256;
    int g = arc4random()%256;
    int b = arc4random()%256;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

@end
