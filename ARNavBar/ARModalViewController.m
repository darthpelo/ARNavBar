//
//  ARProfiloViewController.m
//  ARNavBar
//
//  Created by Niccolò Passolunghi on 29/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARModalViewController.h"
#import "VENavBar.h"

@interface ARModalViewController ()

@property (nonatomic, strong) VENavBar* navBar;

@end

@implementation ARModalViewController

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
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    self.navBar = (VENavBar*)self.navigationController.navigationBar;
    
    [self.navBar.rightButton setHidden:YES];
    [self.navBar.menuButton setHidden:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Chiudi" style:UIBarButtonItemStylePlain target:self action:@selector(chiudi)];
    
    UILabel* modalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 300, 70)];
    [modalLabel setText:@"I'M THE MODAL\nVIEW CONTROLLER"];
    [modalLabel setTextAlignment:NSTextAlignmentCenter];
    [modalLabel setTextColor:[UIColor blackColor]];
    [modalLabel setNumberOfLines:2];
    [modalLabel setFont:[UIFont fontWithName:@"ArialMT" size:30.0f]];
    [self.view addSubview:modalLabel];
}

- (void)chiudi
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
