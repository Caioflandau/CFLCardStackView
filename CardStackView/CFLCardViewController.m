//
//  CFLCardViewController.m
//  CardStackView
//
//  Created by Caio Fukelmann Landau on 05/06/14.
//  Copyright (c) 2014 Caio Fukelmann Landau. All rights reserved.
//

#import "CFLCardViewController.h"

@interface CFLCardViewController ()

@end

@implementation CFLCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor *color;
    
    int a = arc4random()%5;
    switch (a) {
        case 0:
            color = [UIColor redColor];
            break;
            
        case 1:
            color = [UIColor greenColor];
            break;
            
        case 2:
            color = [UIColor blueColor];
            break;
            
        case 3:
            color = [UIColor whiteColor];
            break;
            
        default:
            color = [UIColor whiteColor];
            break;
    }
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
