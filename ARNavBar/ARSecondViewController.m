//
//  ARDetailViewController.m
//  ARNavBar
//
//  Created by Niccolò Passolunghi on 29/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARSecondViewController.h"

@interface ARSecondViewController ()

@end

@implementation ARSecondViewController

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
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
    
    UILabel* secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 70)];
    [secondLabel setText:@"I'M THE SECOND\nVIEW CONTROLLER"];
    [secondLabel setTextAlignment:NSTextAlignmentCenter];
    [secondLabel setTextColor:[UIColor blackColor]];
    [secondLabel setNumberOfLines:2];
    [secondLabel setFont:[UIFont fontWithName:@"ArialMT" size:30.0f]];
    [self.view addSubview:secondLabel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
