//
//  ARContainerViewController.m
//  ARNavBar
//
//  Created by Niccolò Passolunghi on 29/11/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//

#import "ARContainerViewController.h"
#import "ARFirstViewController.h"
#import "ARSecondViewController.h"
#import "VENavBar.h"
#import "ARModalViewController.h"

@interface ARContainerViewController ()

@property (nonatomic, strong) UIViewController* currentViewController;

@property (nonatomic, strong) VENavBar* navBar;

@end

@implementation ARContainerViewController

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
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    self.navBar = (VENavBar*)self.navigationController.navigationBar;
    
    [self.navBar.rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    //Add first child view controller
    ARFirstViewController* vc = [[ARFirstViewController alloc] init];
    [self addNewViewController:vc];
    
    //Create a weak reference to self
    __weak ARContainerViewController* weakSelf = self;
    
    //NavBar block call
    self.navBar.functionRequest = ^(NSInteger number) {
        
        //Add new child view controller based on "number"
        if (number == 0) {
            ARFirstViewController* vc = [[ARFirstViewController alloc] init];
            [weakSelf addNewViewController:vc];
        } else if (number == 1) {
            ARSecondViewController* vc = [[ARSecondViewController alloc] init];
            [weakSelf addNewViewController:vc];
        }
        
    };

}

//Present a Modal View Controller
- (void)rightButtonPressed
{
    ARModalViewController* vc = [[ARModalViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithNavigationBarClass:[VENavBar class] toolbarClass:nil];
    navController.viewControllers = @[vc];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Add New View Controller
- (void)addNewViewController:(UIViewController*)newVc
{
    //Remove the current View Controller showed
    if(self.currentViewController){

        [self.currentViewController willMoveToParentViewController:nil];
        
        [self.currentViewController.view removeFromSuperview];

        [self.currentViewController removeFromParentViewController];
    }
    
    //Add the new controller as child of the container
    [self addChildViewController:newVc];
    
    //New VC's main view size
    newVc.view.frame = self.view.bounds;
    
    //Add the new controller's view to the Container's view and save a reference to the new View Controller
    [self.view addSubview:newVc.view];
    self.currentViewController = newVc;
    
    [newVc didMoveToParentViewController:self];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
