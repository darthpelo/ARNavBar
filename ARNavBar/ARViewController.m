//
//  ARViewController.m
//  ARNavBar
//
//  Created by Alessio Roberto on 03/05/13.
//  Copyright (c) 2013 Alessio Roberto. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "ARViewController.h"

@interface ARViewController ()
@property (nonatomic, strong) VENavBar *navBar;
@end

@implementation ARViewController
@synthesize navBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    navBar = [[VENavBar alloc] initWithFrame:CGRectMake(0, 0, 320, 46) configuration:VENavBarDefault];
    [self.view addSubview:navBar];
    [navBar setUserInteractionEnabled:YES];
    __weak ARViewController *bSelf = self;
    navBar.menuPressed = ^(BOOL isOpen, VENavBar *_navBar){
        if (isOpen) {
            UIView *bkgr = [[UIView alloc] initWithFrame:CGRectMake(0, 44, 320, 548)];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:bSelf action:@selector(tapGesture)];
            [bkgr addGestureRecognizer:tap];
            [bSelf.view addSubview:bkgr];
            [bSelf.view bringSubviewToFront:_navBar];
            [bkgr setBackgroundColor:[UIColor blackColor]];
            bkgr.alpha = 0.0;
            bkgr.tag = 1;
            [UIView animateWithDuration:0.4 animations:^{
                bkgr.alpha = 0.5;
            }];
        } else {
            for (UIView *v in [bSelf.view subviews]) {
                if (v.tag == 1) {
                    [UIView animateWithDuration:0.4 animations:^{
                        v.alpha = 0.0;
                    }completion:^(BOOL finisched){
                        if (finisched) [v removeFromSuperview];
                    }];
                }
            }
        }
    };
    navBar.closePressed = ^{
        [bSelf closeView];
    };
    navBar.functionRequest = ^(NSInteger number){
        for (UIView *v in [bSelf.view subviews]) {
            if (v.tag == 1) {
                [UIView animateWithDuration:0.4 animations:^{
                    v.alpha = 0.0;
                }completion:^(BOOL finisched){
                    if (finisched) [v removeFromSuperview];
                }];
            }
        }
        [bSelf functionsManagment:number];
    };
    
    [self.view addSubview:navBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapGesture
{
    [navBar closeMenu];
    for (UIView *v in [self.view subviews]) {
        if (v.tag == 1) {
            [v removeFromSuperview];
        }
    }
}

- (void)closeView
{
    // Manage VC close
}

- (void)functionsManagment:(NSInteger)number
{
    // Manage functions
}

@end
