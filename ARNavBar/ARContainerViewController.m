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

- (id)initWithViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        [self presentNewViewController:viewController];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    self.navBar = (VENavBar*)self.navigationController.navigationBar;
    
    [self.navBar.rightButton addTarget:self action:@selector(closeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    ARFirstViewController* vc = [[ARFirstViewController alloc] init];
    [self presentNewViewController:vc];
    
    
    __weak ARContainerViewController* weakSelf = self;
    self.navBar.functionRequest = ^(NSInteger number) {
        
        if (number == 1) {
            ARSecondViewController* vc = [[ARSecondViewController alloc] init];
            [weakSelf presentNewViewController:vc];
        } else if (number == 0) {
            ARFirstViewController* vc = [[ARFirstViewController alloc] init];
            [weakSelf presentNewViewController:vc];
        }
        
    };

}

- (void)closeButtonPressed
{
    ARModalViewController* vc = [[ARModalViewController alloc] init];
    UINavigationController* navController = [[UINavigationController alloc] initWithNavigationBarClass:[VENavBar class] toolbarClass:nil];
    navController.viewControllers = @[vc];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - Present New View Controller
- (void)presentNewViewController:(UIViewController*)newVc
{
    //0. Remove the current Detail View Controller showed
    if(self.currentViewController){
        [self removeCurrentDetailViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:newVc];
    
    //2. Define the detail controller's view size
    newVc.view.frame = self.view.bounds;
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    [self.view addSubview:newVc.view];
    self.currentViewController = newVc;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [newVc didMoveToParentViewController:self];
    
    
}

- (void)removeCurrentDetailViewController{
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.currentViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.currentViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
    [self.currentViewController removeFromParentViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
